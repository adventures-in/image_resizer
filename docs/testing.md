# Testing

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

## Testing locally in a container

```shell
$ cd image_resizer
$ docker build -t app .
...

$ docker run -it -p 8080:8080 --name demo --rm app
Listening on :8080
```

In another terminal...

```shell
$ curl localhost:8080
Hello, World!
```

## Getting test data

### Cloud Events

At the start of the function add the following:

```Dart
final eventJson = json.encode(event.toJson());
context.logger.info('[CloudEvent] json: $eventJson');
```

Then trigger the event for which test data is wanted, go to the console and view logs for the relevant service.

Copy the json that comes after "[CloudEvent] json: "

Paste the json into a file called (eg.) `event_data.json` then a locally running (and debugging) instance can be triggered with the data using:

`curl --data-binary @sample/gcs_data.json -H 'content-type: application/json' -w '%{http_code}\n' localhost:8080`
