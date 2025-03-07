import 'package:autojidelna/src/_global/riverpod/analytics/analytics.riverpod.dart';
import 'package:autojidelna/src/lang/l10n_context_extension.dart';
import 'package:autojidelna/src/ui/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnalyticsSwitches extends ConsumerWidget {
  const AnalyticsSwitches({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Texts lang = context.l10n;

    final allowAnalytics = ref.watch(allowAnalyticsNotifierProvider);
    final allowAnalyticsNotifier = ref.read(allowAnalyticsNotifierProvider.notifier);
    final sendCrashLogs = ref.watch(sendCrashLogsNotifierProvider);
    final sendCrashLogsNotifier = ref.read(sendCrashLogsNotifierProvider.notifier);

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
