import 'package:autojidelna/app/app_init.dart';
import 'package:canteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class App {
  static List<Override> initProviderOverrides = [];

  static Future<void> init() async {
    Stopwatch stopwatch = Stopwatch();

    // Start the stopwatch
    stopwatch.start();

    // We're using Future.wait to run multiple Futures in parallel
    // These Futures must take less than 200 ms to run
    await AppInit.hive();
    await AppInit.removeConfig();
    await Future.wait([
      AppInit.localization(),
      AppInit.secureStorage(),
      AppInit.packageInfo(),
      AppInit.rotation(),
      AppInit.codePush(),
      // TODO: App.initNotifications(),
    ]);
    // Stop the stopwatch
    stopwatch.stop();

    // Get the elapsed time
    Duration elapsed = stopwatch.elapsed;
    debugPrint('Initialization took ${elapsed.inMilliseconds} ms');
  }

  /// Call this after retrieving the URL
  void registerCanteen(Canteen canteen) async {
    if (getIt.isRegistered<Canteen>()) getIt.unregister<Canteen>();
    getIt.registerLazySingleton<Canteen>(() => canteen);
  }

  static late final bool shouldAskForNotification;

  static const defaultRotations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];

  static final GetIt getIt = GetIt.instance;

  static PageController pageController = PageController();
  static FlutterListViewController listController = FlutterListViewController();
}
