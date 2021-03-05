# Extract info from CloudEvent

## Context Attributes | OPTIONAL

[subject](https://github.com/cloudevents/spec/blob/v1.0.1/spec.md#subject)

## Steps

The `event` object has a subject `member` that hold the relevant info, eg:

`storage.googleapis.com/projects/_/buckets/cr-bucket-the-process-tool/objects/random.txt`

We can pull out the `bucket` and `object` name with:

```Dart
final parts = event.subject?.split('/') ?? []; 
final bucketName = parts.elementAt(parts.indexOf('buckets') + 1);
final objectName = parts.elementAt(parts.indexOf('objects') + 1);
```
