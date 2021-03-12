# Debug

Create a launch configuration with:

```json
{
  "name": "image_resizer",
  "request": "launch",
  "type": "dart",
  "program": "bin/server.dart",
  "args": ["--signature-type", "cloudevent"]
}
```

Add a breakpoint and hit RUN AND DEBUG.

Use curl to send a sample cloud event:

```sh
curl --data-binary @sample/gcs_data.json -H 'content-type: application/json' -w '%{http_code}\n' localhost:8080
```

The file `gcs_data.json` contains test data, obtained following [Get Test Data](get_test_data.md)

BOOM!... bugs begone!
