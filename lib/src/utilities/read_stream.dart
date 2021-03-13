Future<List<int>> readStream(Stream<List<int>> stream) async {
  var list = <int>[];
  await for (var value in stream) {
    list += value;
  }
  return list;
}
