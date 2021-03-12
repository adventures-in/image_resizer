import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:functions_framework/functions_framework.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

@CloudFunction()
FutureOr<void> function(CloudEvent event, RequestContext context) async {
  final eventJson = json.encode(event.toJson());
  context.logger.info('[CloudEvent] json: $eventJson');

  final serviceClient =
      await clientViaApplicationDefaultCredentials(scopes: []);
  final storageApi = StorageApi(serviceClient);

  final bucketItems = (await storageApi.buckets.list('the-process-tool')).items;
  if (bucketItems == null) return;
  for (var bucket in bucketItems) {
    print(bucket.name);
  }

  final parts = event.subject?.split('/') ?? [];
  final bucketName = parts.elementAt(parts.indexOf('buckets') + 1);
  final objectName = parts.elementAt(parts.indexOf('objects') + 1);

  final media = await storageApi.objects.get(bucketName, objectName,
      downloadOptions: DownloadOptions.fullMedia) as Media;

  final sink = File('/tmp/file.png').openWrite();
  await sink.addStream(media.stream);

  print(media.contentType);
  context.logger.info('[Media] type: ${media.contentType}');
}
