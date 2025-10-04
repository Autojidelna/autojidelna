import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/app/app_providers.dart';
import 'package:autojidelna/app/migration/migration_manager.dart';
import 'package:autojidelna/app/material_app.dart';
import 'package:autojidelna/shared/providers/eager_initialization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await App.init();
  await MigrationManager.runMigrations();

  runApp(
    UncontrolledProviderScope(
      container: App.globalContainer,
      child: const EagerInitialization(providers: [packageInfoProvider], child: MyApp()),
    ),
  );
}
