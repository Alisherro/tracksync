import 'dart:isolate';

class IsolateParser<T> {
  final Map<String, dynamic> json;
  final T Function(dynamic response) converter;

  IsolateParser(this.json, this.converter);

  Future<T> parseInBackground() async {
    final port = ReceivePort();
    await Isolate.spawn(_parseListOfJson, port.sendPort);

    final result = await port.first;
    return result as T;
  }

  Future<void> _parseListOfJson(SendPort sendPort) async {
      final result = converter(json);
      Isolate.exit(sendPort, result);
  }
}
