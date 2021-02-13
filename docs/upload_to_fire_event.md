# Upload file to fire an event

## Export bucket name (if not done)

```sh
export BUCKET_NAME=cr-bucket-$(gcloud config get-value project)
```

## Updoad a file

```sh
echo "Hello World" > random.txt
gsutil cp random.txt gs://${BUCKET_NAME}/random.txt
```
