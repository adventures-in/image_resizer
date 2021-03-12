# Create an event trigger

See Codelab: [Trigger Cloud Run with events from Eventarc](https://codelabs.developers.google.com/codelabs/cloud-run-events#0) > [9. Create an Event trigger for Cloud Audit Logs](https://codelabs.developers.google.com/codelabs/cloud-run-events#8)

Set up a trigger to listen for Cloud Storage events in Cloud Audit Logs.

## Create a bucket

Create a Cloud Storage bucket in the same region as the deployed Cloud Run service - replace BUCKET_NAME with a unique name if preferred:

```sh
export BUCKET_NAME=cr-bucket-$(gcloud config get-value project)
gsutil mb -p $(gcloud config get-value project) \
  -l $(gcloud config get-value run/region) \
  gs://${BUCKET_NAME}/
```

## Enable Cloud Audit Logs

In order to receive events from a service, enable Cloud Audit Logs.

- From the Cloud Console, select `IAM & Admin` and `Audit Logs` from the upper left-hand menu.
- In the list of services, check Google Cloud Storage:

![List with Google Cloud Storage checked](https://codelabs.developers.google.com/codelabs/cloud-run-events/img/3053afc271d2734c.png)

On the right hand side, make sure Admin, Read and Write are selected. Click save:

![Log Type options](https://codelabs.developers.google.com/codelabs/cloud-run-events/img/bec31b4f35fbcea.png)

## Test Cloud Audit Logs

To learn how to identify the parameters needed to set up an actual trigger, perform an actual operation.

For example, create a random text file and upload it to the bucket:

```sh
echo "Hello World" > random.txt
gsutil cp random.txt gs://${BUCKET_NAME}/random.txt
```

Now, let's see what kind of audit log this update generated. From the Cloud Console, select `Logging` and `Logs Viewer` from the upper left-hand menu.

Under `Query Builder`, choose `GCS Bucket` and choose your bucket and its location. Click `Add`.

![Logs viewer with bucket selected](https://codelabs.developers.google.com/codelabs/cloud-run-events/img/db831de1a42ea560.png)

> :warning: There is some latency for audit logs to show up in Logs Viewer UI. If the GCS Bucket is not shown under the list of resources, wait a little before trying again.

Running the query shows logs for the storage bucket and one of those should be `storage.objects.create`:

![Query Results](https://codelabs.developers.google.com/codelabs/cloud-run-events/img/df57e9799dde5b8.png)

Note the `serviceName`, `methodName` and `resourceName`.

## Create a trigger

Create an event trigger for Cloud Audit Logs.

Get more details on the parameters needed to construct the trigger:

`gcloud beta eventarc attributes types describe google.cloud.audit.log.v1.written`

Create the trigger with the right filters and the service account:

Use the SERVICE_NAME created earlier and the REGION that the bucet is in.

`export SERVICE_NAME=image-resizer`
`export REGION=us-central1`
`export PROJECT_NUMBER="$(gcloud projects list --filter=$(gcloud config get-value project) --format='value(PROJECT_NUMBER)')"`

```sh
gcloud eventarc triggers create trigger-auditlog \
  --destination-run-service=${SERVICE_NAME} \
  --destination-run-region=${REGION} \
  --event-filters="type=google.cloud.audit.log.v1.written" \
  --event-filters="serviceName=storage.googleapis.com" \
  --event-filters="methodName=storage.objects.create" \
  --service-account=${PROJECT_NUMBER}-compute@developer.gserviceaccount.com
```

<details>
  <summary>A note on resourceName parameter</summary>
  - There is an optional resourceName field. Providing a complete resource path (eg. projects/_/buckets/test123) will filter for events pertaining to the specific resource. Providing no resource path at all will filter for events for any resource corresponding to the provided serviceName and methodName. Partial resource names (eg. projects/project-id) are not accepted and will malfunction.
  - For methodsNames that are of a ‘create' variety (eg. storage.buckets.create for creating a Google Cloud Storage bucket) resourceNames are best left blank as resourceName may be dynamically generated for some serviceNames and cannot be predicted beforehand.
  - For methodNames that are of a ‘read', ‘update' or ‘delete' variety (eg. storage.buckets.update for updating a specific Google Cloud Storage bucket), you may specify the complete resource path.
</details>

## Test the trigger

List all triggers to confirm that trigger was successfully created:

`gcloud eventarc triggers list`

The trigger may take up to 10 minutes to be propagated and for it to begin filtering events. Once ready, it will filter create events and send them to the service.

Upload the same file to the Cloud Storage bucket again:

`gsutil cp random.txt gs://${BUCKET_NAME}/random.txt`

Lhe logs of the Cloud Run service in Cloud Console should show the received event:

![Logs showing expected event](https://codelabs.developers.google.com/codelabs/cloud-run-events/img/aff3b2e7ad05c75d.png)
