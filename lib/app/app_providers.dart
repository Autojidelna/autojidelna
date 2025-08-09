import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

@Riverpod(keepAlive: true)
GlobalKey<ScaffoldMessengerState> scaffoldMessenger(Ref ref) => GlobalKey<ScaffoldMessengerState>();

@Riverpod(keepAlive: true)
PackageInfo? packageInfo(Ref ref) => null;

@Riverpod(keepAlive: true)
int? currentPatchNumber(Ref ref) => null;
