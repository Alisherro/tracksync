import 'dart:isolate';

class IsolateParser<T> {
  final Map<String, dynamic> json;
  final T Function(dynamic response) converter;

  IsolateParser(this.json, this.converter);

  Future<T> parseInBackground() async {
    final T result = await Isolate.run<T>(()=>converter(json));
    return result;
  }
}
