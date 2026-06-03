import 'dart:async';

import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/app/migration/migration_manager.dart';
import 'package:autojidelna/app/material_app.dart';
import 'package:autojidelna/core/logging/emergency_crash_app.dart';
import 'package:autojidelna/core/logging/local_logger.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  if (kDebugMode) BindingBase.debugZoneErrorsAreFatal = true;

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await LocalLogger.init();

      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        LocalLogger.logError('Flutter Error', details.exception, details.stack);
        EmergencyCrashPage.show(details.exceptionAsString(), details.stack);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        LocalLogger.logError('Platform Error', error, stack);
        EmergencyCrashPage.show(error.toString(), stack);
        return true;
      };

      // Called when a widget build fails
      ErrorWidget.builder = (FlutterErrorDetails details) {
        LocalLogger.logError('Widget build Error', details.exception, details.stack);
        EmergencyCrashPage.show(details.exceptionAsString(), details.stack);
        return const Scaffold();
      };

      await App.init();
      await MigrationManager.runMigrations();

      runApp(ProviderScope(observers: [RiverpodLogger()], child: const MyApp()));
    },
    (error, stack) {
      LocalLogger.logError('Zone Error', error, stack);
      EmergencyCrashPage.show(error.toString(), stack);
    },
  );
}
