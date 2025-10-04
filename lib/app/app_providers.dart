import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

@Riverpod(keepAlive: true)
GlobalKey<ScaffoldMessengerState> scaffoldMessenger(Ref ref) => GlobalKey<ScaffoldMessengerState>();

@Riverpod(keepAlive: true)
Future<PackageInfo> packageInfo(Ref ref) async => await PackageInfo.fromPlatform();

@Riverpod(keepAlive: true)
int? currentPatchNumber(Ref ref) => null;
