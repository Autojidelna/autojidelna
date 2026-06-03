import 'dart:async';

import 'package:autojidelna/app/app_init.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restart_app/restart_app.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class App {
  static List<Override> initProviderOverrides = [];

  static Future<void> init() async {
    Stopwatch stopwatch = Stopwatch();

    // Start the stopwatch
    stopwatch.start();

    // We're using Future.wait to run multiple Futures in parallel
    // These Futures must take less than 200 ms to run
    await AppInit.hive();
    unawaited(AppInit.awesomeNotifications());

    SystemChrome.setPreferredOrientations(_defaultRotations);

    stopwatch.stop();
    Duration elapsed = stopwatch.elapsed;
    debugPrint('Initialization took ${elapsed.inMilliseconds} ms');
  }

  static Future<void> backgroundInit() async {
    await AppInit.hive();
    await AppInit.awesomeNotifications();
  }

  static Future<void> restart(BuildContext context) async {
    Fluttertoast.showToast(msg: context.l10n.restartingAutojidelna);
    Restart.restartApp();
  }

  static final bool shouldAskForNotification = true;

  static const _defaultRotations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessenger = GlobalKey<ScaffoldMessengerState>();
  static final navigatorKey = GlobalKey<NavigatorState>();

  static PageController pageController = PageController();
  static FlutterListViewController listController = FlutterListViewController();
}
