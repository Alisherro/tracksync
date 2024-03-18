import 'package:sentry_flutter/sentry_flutter.dart';
import 'dart:developer';

mixin class SentryCrashLogger {
  Future<void> nonFatalError(
      {required dynamic error, required StackTrace stackTrace}) async {
    log(error.toString());
    log(stackTrace.toString());
    await Sentry.captureException(error, stackTrace: stackTrace);
  }
}
