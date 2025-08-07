import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/analytics/presentation/analytics_switches.dart';
import 'package:autojidelna/shared/widgets/configured_alert_dialog.dart';
import 'package:autojidelna/shared/widgets/configured_dialog.dart';
import 'package:autojidelna/shared/widgets/scroll_view_column.dart';
import 'package:autojidelna/shared/widgets/section_title.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.analytics)),
      body: ScrollViewColumn(
        children: [
          SectionTitle(l10n.analytics, moreInfo: () => moreInfo(context, l10n)),
          const AnalyticsSwitches(),
        ],
      ),
    );
  }

  void moreInfo(BuildContext context, L10n l10n) => configuredDialog(
        context,
        builder: (context) => ConfiguredAlertDialog(
          title: l10n.moreInfo,
          content: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(l10n.analyticsMoreInfo)),
          customCancelText: l10n.ok,
        ),
      );
}
