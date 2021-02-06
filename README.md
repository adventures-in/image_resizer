# Automatically resize images uploaded to Google Cloud Storage

Replicating the [Resize Images Firebase Extension](https://firebase.google.com/products/extensions/storage-resize-images) using the [Dart Functions Framework](https://github.com/GoogleCloudPlatform/functions-framework-dart).

## Configure GCP project for running on Cloud Run

[Trigger Cloud Run with events from Eventarc](https://codelabs.developers.google.com/codelabs/cloud-run-events#4)

## Reviewing logs 

<https://console.cloud.google.com/logs/query;timeRange=PT1H?project=...>


## A Dart function handles CloudEvents

CloudEvent function handlers don't return a response to send to the event
producter. They generally perform some work and print output for logging.

The basic shape of the function handler looks like this:

```dart
@CloudFunction()
void function(CloudEvent event, RequestContext context) {
}
```

Or like this if it needs to perform work that will complete sometime in the
future:

```dart
@CloudFunction()
FutureOr<void> function(CloudEvent event, RequestContext context) async {
}
```

## Generate server.dart

The Dart `build_runner` tool generates `bin/server.dart`, the main entry point
for the function server app, which invokes the function in `lib/functions.dart`.

Run the `build_runner` tool, as shown here:

```shell
$ dart run build_runner build
[INFO] Generating build script completed, took 337ms
[INFO] Reading cached asset graph completed, took 48ms
[INFO] Checking for updates since last build completed, took 426ms
[INFO] Running build completed, took 13ms
[INFO] Caching finalized dependency graph completed, took 29ms
[INFO] Succeeded after 51ms with 0 outputs (0 actions)
```

## Running tests

```shell
$ dart test
00:02 +1: All tests passed!
```

## Testing the function locally

The default signature type for a function is for handling normal HTTP requests.
When running a function for handling a cloudevent, you must either set
the `FUNCTION_SIGNATURE_TYPE` environment variable or the
`--signature-type` command line option to `cloudevent`, as shown below:

```shell
$ dart run bin/server.dart --signature-type cloudevent
Listening on :8080
```

From another terminal, trigger the CloudEvent by posting event data:

```shell
$ curl --data-binary @sample/data.json -H 'content-type: application/json' -w '%{http_code}\n' localhost:8080
200
```

Tools like [curl] (and [postman]) are good for sending HTTP requests. The
options used in this example are:

- `--data-binary @sample/data.json` - set the request body to a JSON document
  read from the file `sample/data.json`
- `-H "content-type: application/json"` - set an HTTP header to indicate that
  the body is a JSON document
- `-w '%{http_code}\n'` - print the HTTP status code (expect 200 for success)

Alternatively, instead of running `curl`, you can run either of the following
Dart scripts examples under the `examples/raw_cloudevent/tool` directory:

- `dart run tool/binary_mode_request.dart`
- `dart run tool/structured_mode_request.dart`

For more details see quick start guides:

- [Quickstart: Dart]
- [Quickstart: Docker]
- [Quickstart: Cloud Run]

<!-- reference links -->
[curl]: https://curl.se/docs/manual.html
[Quickstart: Dart]: https://github.com/GoogleCloudPlatform/functions-framework-dart/blob/main/docs/quickstarts/01-quickstart-dart.md
[Quickstart: Docker]: https://github.com/GoogleCloudPlatform/functions-framework-dart/blob/main/docs/quickstarts/02-quickstart-docker.md
[Quickstart: Cloud Run]: https://github.com/GoogleCloudPlatform/functions-framework-dart/blob/main/docs/quickstarts/03-quickstart-cloudrun.md
[postman]: https://www.postman.com/product/api-client/
