import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:functions_framework/functions_framework.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:image/image.dart';
import 'package:image_resizer/src/utilities/parse_storage_event.dart';
import 'package:image_resizer/src/utilities/read_stream.dart';

@CloudFunction()
FutureOr<void> function(CloudEvent event, RequestContext context) async {
  final eventJson = json.encode(event.toJson());
  context.logger.info('[CloudEvent] json: $eventJson');

  final serviceClient =
      await clientViaApplicationDefaultCredentials(scopes: []);
  final storageApi = StorageApi(serviceClient);

  final eventInfo = parseStorageEvent(event);

  final media = await storageApi.objects.get(
      eventInfo.bucketName, eventInfo.objectName,
      downloadOptions: DownloadOptions.fullMedia) as Media;

  final imageBytes = await readStream(media.stream);
  final image = decodeImage(imageBytes)!;

  var thumbnail = copyResize(image, width: 120);

  final bytes = thumbnail.getBytes();
  final length = bytes.length;

  final newMedia = Media(Stream.fromIterable([bytes]), length,
      contentType: media.contentType);

  // TODO: avoid recursive operations
  // Upload to one bucket and have the resized images (with or without the
  // original) go to the bucket that serves the images (that has no trigger).
  // await storageApi.objects.insert(Object(), 'newName', uploadMedia: newMedia);

  final sink = File('/tmp/file.png').openWrite();
  await sink.addStream(newMedia.stream);

  print(media.contentType);
  context.logger.info('[Media] type: ${media.contentType}');
}
