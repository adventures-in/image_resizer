# Automatically resize images uploaded to Google Cloud Storage

A [Dart Functions Framework](https://github.com/GoogleCloudPlatform/functions-framework-dart) project inspired by the [Resize Images Firebase Extension](https://firebase.google.com/products/extensions/storage-resize-images).

[Notes](https://docs.google.com/document/d/1PYeSgfAjoRGn09nK1j-s0cfQkz1kJfV_rg5Al6YQ3Bs/edit?usp=sharing)

## Quickstart

[Configure a GCP project](docs/configure_gcp.md)

## Contributing

Review [Testing](docs/testing.md) for easy ways to test changes.

## Technical Info

### A Dart function handles CloudEvents

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

[generate server.dart](docs/generate_server.md)

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
