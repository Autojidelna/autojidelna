import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:autojidelna/shared/widgets/scroll_view_column.dart';
import 'package:flutter/foundation.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;
    final StackRouter router = context.router;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ScrollViewColumn(
        children: [
          const CustomDivider(height: 4),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: Text(l10n.appearance),
            onTap: () async => router.navigate(const AppearanceRoute()),
          ),
          ListTile(
            leading: const Icon(Icons.tune_outlined),
            title: Text(l10n.convenience),
            onTap: () async => router.navigate(const ConvenienceRoute()),
          ),
          /*ListTile(
            leading: const Icon(Icons.edit_notifications_outlined),
            title: Text(l10n.notifications),
            onTap: () async => AwesomeNotifications().showNotificationConfigRoute(),
          ),*/
          ListTile(
            leading: const Icon(Icons.cookie_outlined),
            title: Text(l10n.analytics),
            onTap: () async => router.navigate(const AnalyticsRoute()),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.about),
            onTap: () async => router.navigate(const AboutRoute()),
          ),
          if (!kReleaseMode)
            ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: Text(l10n.debug),
              onTap: () async => router.navigate(const DebugRoute()),
            ),
        ],
      ),
    );
  }
}
