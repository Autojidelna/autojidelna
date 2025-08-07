import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/dev/crash_logic.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:autojidelna/dev/presentation/test_notifications.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.l10n;
    return Scaffold(
      appBar: AppBar(title: const Text('Debug')),
      body: ListView(
        children: <Widget>[
          TextField(
            onChanged: (value) async => value == 'crash' ? crashTestFunction() : null,
            decoration: InputDecoration(
              labelText: lang.typeCrash,
              border: const OutlineInputBorder(),
            ),
          ),
          ListTile(
            title: const Text('Show error Snack Bar'),
            onTap: () => showErrorSnackBar(SnackBarAuthErrors.connectionFailed(context.l10n)),
          ),
          ListTile(
            title: const Text('Show info Snack Bar'),
            onTap: () => showInfoSnackBar(Icons.wifi_off_rounded, lang.appName, lang.appDescription),
          ),
          ListTile(
            title: const Text('Onboarding guide'),
            onTap: () async => context.router.push(OnboardingRoute()),
          ),
          const NotificationActionButton(),
        ],
      ),
    );
  }
}
