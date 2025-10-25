import 'dart:async';

import 'package:autojidelna/app/app_init.dart';
import 'package:autojidelna/core/firebase/firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class App {
  static List<Override> initProviderOverrides = [];

  static Future<void> init() async {
    Stopwatch stopwatch = Stopwatch();

    // Start the stopwatch
    stopwatch.start();

    // We're using Future.wait to run multiple Futures in parallel
    // These Futures must take less than 200 ms to run
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await AppInit.hive();
    await AppInit.firebaseCrashlytics();
    unawaited(
      Future.wait([
        AppInit.firebaseAnalytics(),
        AppInit.firebaseRemoteConfig(),
        AppInit.firebaseMessaging(),
        AppInit.awesomeNotifications(),
        AppInit.codePush(),
      ]),
    );

    SystemChrome.setPreferredOrientations(_defaultRotations);

    // Stop the stopwatch
    stopwatch.stop();

    // Get the elapsed time
    Duration elapsed = stopwatch.elapsed;
    debugPrint('Initialization took ${elapsed.inMilliseconds} ms');
  }

  static Future<void> backgroundInit() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await AppInit.hive();
    await AppInit.awesomeNotifications();
  }

  static late final bool shouldAskForNotification;

  static const _defaultRotations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];

  static final globalContainer = ProviderContainer(overrides: initProviderOverrides);

  static PageController pageController = PageController();
  static FlutterListViewController listController = FlutterListViewController();
}
