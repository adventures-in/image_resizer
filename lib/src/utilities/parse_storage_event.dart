import 'package:functions_framework/functions_framework.dart';
import 'package:image_resizer/src/models/storage_event_info.dart';

StorageEventInfo parseStorageEvent(CloudEvent event) {
  final parts = event.subject?.split('/') ?? [];
  final bucketName = parts.elementAt(parts.indexOf('buckets') + 1);
  final objectName = parts.elementAt(parts.indexOf('objects') + 1);
  return StorageEventInfo(bucketName: bucketName, objectName: objectName);
}
