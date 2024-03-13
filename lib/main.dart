import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:tracksync/tracksync_app.dart';
import 'dependencies_injection.dart';

void main() {
  runZonedGuarded(
    () async {
      await SentryFlutter.init((options) {
        options.dsn =
            "https://5fb978de73c822f9ef33ca571211e00f@o4506539902107648.ingest.us.sentry.io/4506896984244224";
        options.tracesSampleRate = 0.01;
      }, appRunner: () async {
        WidgetsFlutterBinding.ensureInitialized();
        await setupLocator();
        return SystemChrome.setPreferredOrientations(
          [
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ],
        ).then((_) => runApp(TrackSyncApp()));
      });
    },
    (error, stackTrace) async {},
  );
}
