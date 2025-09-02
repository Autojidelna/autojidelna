import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/dev/crash_logic.dart';
import 'package:autojidelna/dev/presentation/test_notifications.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hive/hive.dart';

@RoutePage()
class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: const Text('Debug')),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: TextField(
              onChanged: (value) async => value == 'crash' ? crashTestFunction() : null,
              decoration: InputDecoration(
                labelText: l10n.debugTypeCrash,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          ListTile(
            title: const Text('Show error Snack Bar'),
            onTap: () => showErrorSnackBar(SnackBarAuthErrors.connectionFailed(context.l10n)),
          ),
          ListTile(
            title: const Text('Show info Snack Bar'),
            onTap: () => showInfoSnackBar(Icons.wifi_off_rounded, l10n.appName, l10n.appDescription),
          ),
          ListTile(
            title: const Text('Onboarding guide'),
            onTap: () async => context.router.push(
              OnboardingRoute(onCompletedCallback: (p0) => context.router.navigate(const RouterRoute())),
            ),
          ),
          ListTile(
            title: const Text('Set AppState.firstTime to true'),
            onTap: () => Hive.box(Boxes.appState).put(HiveKeys.appState.firstTime, true),
          ),
          const NotificationActionButton(),
        ],
      ),
    );
  }
}
