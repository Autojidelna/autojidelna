import 'dart:async';

import 'package:autojidelna/shared/config/hive.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MigrationManager {
  static Future<void> runMigrations() async {
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();

    final String currentVersion = (await PackageInfo.fromPlatform()).version;
    final String? lastKnownVersion = Hive.box(Boxes.appState).get(HiveKeys.appState.lastVersion, defaultValue: '1.0.0');

    if (lastKnownVersion == null || _isNewerVersion(lastKnownVersion, currentVersion)) {
      await _runMigrationScripts(lastKnownVersion, currentVersion);
      Hive.box(Boxes.appState).put(HiveKeys.appState.lastVersion, currentVersion);
    }

    stopwatch.stop();
    Duration elapsed = stopwatch.elapsed;
    debugPrint('Migration took ${elapsed.inMilliseconds} ms');
  }

  static bool _isNewerVersion(String oldVersion, String newVersion) {
    List<int> oldParts = oldVersion.split('.').map(int.parse).toList();
    List<int> newParts = newVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < newParts.length; i++) {
      if (i >= oldParts.length || newParts[i] > oldParts[i]) return true;
      if (newParts[i] < oldParts[i]) return false;
    }
    return false;
  }

  static Future<void> _runMigrationScripts(String? oldVersion, String newVersion) async {
    debugPrint('Running migrations from $oldVersion to $newVersion');

    // First time user
    if (oldVersion == null) return;

    // Add new migrations here
    /*if (_isNewerVersion(oldVersion, '2.0.0')) {
      await _migrateToX_X_X();
      oldVersion = '2.0.0';
    }*/
  }

  // static Future<void> _migrateToX_X_X() async {}
}
