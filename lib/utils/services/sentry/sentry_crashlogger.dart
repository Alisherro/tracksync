import 'package:sentry_flutter/sentry_flutter.dart';

mixin class SentryCrashLogger {
  Future<void> nonFatalError(
      {required dynamic error, required StackTrace stackTrace}) async {
    await Sentry.captureException(error, stackTrace: stackTrace);
  }
}
