import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/analytics/presentation/analytics_switches.dart';
import 'package:autojidelna/src/ui/widgets/dialogs/configured_alert_dialog.dart';
import 'package:autojidelna/src/ui/widgets/dialogs/configured_dialog.dart';
import 'package:autojidelna/shared/widgets/scroll_view_column.dart';
import 'package:autojidelna/shared/widgets/section_title.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final L10n lang = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(lang.analytics)),
      body: ScrollViewColumn(
        children: [
          SectionTitle(lang.analytics, moreInfo: () => moreInfo(context, lang)),
          const AnalyticsSwitches(),
        ],
      ),
    );
  }

  void moreInfo(BuildContext context, L10n lang) => configuredDialog(
        context,
        builder: (context) => ConfiguredAlertDialog(
          title: lang.moreInfo,
          content: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(lang.analyticsMoreInfo)),
          customCancelText: lang.ok,
        ),
      );
}
