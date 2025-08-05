import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/firebase_options.dart';
import 'package:autojidelna/shared/config/tokens.dart';
import 'package:autojidelna/app/migration/migration_manager.dart';
import 'package:autojidelna/app/material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  // Get the current patch number. This will be null if no patch is installed.
  if (!kDebugMode && !kReleaseMode) {
    //TODO: Enable Sentry if data collection is allowed
    await SentryFlutter.init(
      (options) {
        options.dsn = Tokens.sentryDsn;
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
        // The sampling rate for profiling is relative to tracesSampleRate
        // Setting to 1.0 will profile 100% of sampled transactions:
        options.profilesSampleRate = 1.0;
        // options.enableMetrics = true;
        options.reportPackages = true;
        options.attachThreads = true;
        options.enableWindowMetricBreadcrumbs = true;
        options.enableAutoNativeBreadcrumbs = true;
        options.sendDefaultPii = true;
        options.reportSilentFlutterErrors = true;
        options.attachScreenshot = true;
        options.screenshotQuality = SentryScreenshotQuality.full;
        options.attachViewHierarchy = true;
        options.enableTimeToFullDisplayTracing = true;
        // We can enable Sentry debug logging during development. This is likely
        // going to log too much for your app, but can be useful when figuring out
        // configuration issues, e.g. finding out why your events are not uploaded.

        options.maxRequestBodySize = MaxRequestBodySize.always;
        options.maxResponseBodySize = MaxResponseBodySize.always;
      },
      appRunner: runMyApp,
    );
  } else {
    runMyApp();
  }
  // or define SENTRY_DSN via Dart environment variable (--dart-define)
}

void runMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await App.init();
  await MigrationManager.runMigrations();

  if (!kDebugMode) {
    runApp(
      ProviderScope(
        overrides: App.initProviderOverrides,
        child: SentryWidget(
          child: DefaultAssetBundle(
            bundle: SentryAssetBundle(),
            child: const MyApp(),
          ),
        ),
      ),
    );
  } else {
    runApp(const ProviderScope(child: MyApp()));
  }
}
