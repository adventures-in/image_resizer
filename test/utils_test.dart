import 'package:test/test.dart';

void main() {
  group('Utils', () {
    test('parseStorageEvent', () {
      final storageEventData =
          'storage.googleapis.com/projects/_/buckets/cr-bucket-the-process-tool/objects/random.txt';

      final parts = storageEventData.split('/');
      final bucketName = parts.elementAt(parts.indexOf('buckets') + 1);
      final objectName = parts.elementAt(parts.indexOf('objects') + 1);
      expect(bucketName, 'cr-bucket-the-process-tool');
      expect(objectName, 'random.txt');
    });
  });
}
