import 'dart:async';
import 'dart:convert';

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

  final buckets = await storageApi.buckets.list('the-process-tool');
  for (var bucket in buckets.items) {
    print(bucket.name);
  }

  final parts = event.subject?.split('/') ?? [];
  final bucketName = parts.elementAt(parts.indexOf('buckets') + 1);
  final objectName = parts.elementAt(parts.indexOf('objects') + 1);

  final media = await storageApi.objects.get(bucketName, objectName,
      downloadOptions: DownloadOptions.FullMedia) as Media;
  print(media.contentType);
}
