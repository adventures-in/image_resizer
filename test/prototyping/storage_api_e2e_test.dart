// import 'package:googleapis/storage/v1.dart';
// import 'package:googleapis_auth/auth_io.dart';
import 'package:test/test.dart';

void main() {
  group('StorageApi', () {
    test('test', () async {
      // final bucketItems = (await storageApi.buckets.list('the-process-tool')).items;
      // if (bucketItems == null) return;
      // for (var bucket in bucketItems) {
      //   print(bucket.name);
      // }

      // final json = readFromFile
      // final accountCredentials = ServiceAccountCredentials.fromJson(json);
      // final serviceClient = await clientViaServiceAccount(
      //     accountCredentials, [StorageApi.devstorageReadOnlyScope]);

      // final storageApi = StorageApi(serviceClient);

      // final media = await storageApi.objects.get(bucketName, objectName,
      //     downloadOptions: DownloadOptions.FullMedia) as Media;
      // print(media.contentType);
    });
  }, skip: true);
}
