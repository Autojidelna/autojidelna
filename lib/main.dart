import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/app/migration/migration_manager.dart';
import 'package:autojidelna/app/material_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await App.init();
  await MigrationManager.runMigrations();

  runApp(
    ProviderScope(
      overrides: App.initProviderOverrides,
      child: const MyApp(),
    ),
  );
}
