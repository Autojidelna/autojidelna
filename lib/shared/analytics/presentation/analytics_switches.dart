import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/analytics/application/analytics_notifiers.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnalyticsSwitches extends ConsumerWidget {
  const AnalyticsSwitches({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n lang = context.l10n;

    final allowAnalytics = ref.watch(allowAnalyticsProvider);
    final allowAnalyticsNotifier = ref.read(allowAnalyticsProvider.notifier);
    final sendCrashLogs = ref.watch(sendCrashLogsProvider);
    final sendCrashLogsNotifier = ref.read(sendCrashLogsProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SwitchListTile(
          dense: false,
          title: Text(lang.allowAnalytics),
          subtitle: Text(lang.allowAnalyticsSubtitle),
          value: allowAnalytics,
          onChanged: allowAnalyticsNotifier.update,
        ),
        const CustomDivider(height: 8),
        SwitchListTile(
          dense: false,
          title: Text(lang.sendCrashLogs),
          subtitle: Text(lang.sendCrashLogsSubtitle),
          value: sendCrashLogs,
          onChanged: sendCrashLogsNotifier.update,
        ),
      ],
    );
  }
}
