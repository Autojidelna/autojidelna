import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/app/app_providers.dart';
import 'package:autojidelna/app/migration/migration_manager.dart';
import 'package:autojidelna/app/material_app.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await App.init();
  await MigrationManager.runMigrations();

  runApp(
    UncontrolledProviderScope(
      container: App.globalContainer,
      child: const _EagerInitialization(child: MyApp()),
    ),
  );
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Eagerly initialize providers by watching them.
    // By using "watch", the provider will stay alive and not be disposed.
    ref.watch(packageInfoProvider);
    return child;
  }
}
