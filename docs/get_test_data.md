# Get test data

## Cloud Events

At the start of the function add the following:

```Dart
final eventJson = json.encode(event.toJson());
context.logger.info('[CloudEvent] json: $eventJson');
```

Then trigger the event for which test data is wanted, go to the console and view logs for the relevant service.

Copy the json that comes after "[CloudEvent] json: "

Paste the json into a file called (eg.) `event_data.json` then a locally running (and debugging) instance can be triggered with the data using:

`curl --data-binary @sample/gcs_data.json -H 'content-type: application/json' -w '%{http_code}\n' localhost:8080`
