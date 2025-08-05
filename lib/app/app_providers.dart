import 'dart:async';

import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/src/_global/providers/remote_config.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

@Riverpod(keepAlive: true)
Rmc remoteConfig(Ref ref) => Rmc();

@Riverpod(keepAlive: true)
class CurrentLocale extends _$CurrentLocale {
  final Box _box = Hive.box(Boxes.appState);

  @override
  Locale build() => _box.get(HiveKeys.appState.locale, defaultValue: false);

  void update(Locale newLocale) {
    state = newLocale;
    unawaited(_box.put(HiveKeys.appState.locale, newLocale));
  }
}

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) => const FlutterSecureStorage();

@Riverpod(keepAlive: true)
PackageInfo? packageInfo(Ref ref) => null;

@Riverpod(keepAlive: true)
int? currentPatchNumber(Ref ref) => null;
