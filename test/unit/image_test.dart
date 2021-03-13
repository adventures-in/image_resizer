import 'dart:io';

import 'package:image/image.dart';
import 'package:image_resizer/src/utilities/read_stream.dart';
import 'package:test/test.dart';

void main() {
  group('Image', () {
    test('resize creates a valid image', () async {
      final inputFile = File('test/data/project_specific/nick.png');

      final imageBytes = await readStream(inputFile.openRead());

      final image = decodeImage(imageBytes)!;

      var thumbnail = copyResize(image, width: 120);

      await File('/tmp/file.png').writeAsBytes(encodePng(thumbnail));

      // final bytes = thumbnail.getBytes();
      // final stream = Stream.fromIterable([bytes]);

      // final sink = File('/tmp/file.png').openWrite();

      // await sink.addStream(stream);
    });
  }, skip: true);
}
