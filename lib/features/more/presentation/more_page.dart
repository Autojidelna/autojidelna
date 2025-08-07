import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/shared/config/links.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:autojidelna/features/more/presentation/account_overview_card.dart';
import 'package:autojidelna/features/more/presentation/location_picker_card.dart';
import 'package:autojidelna/shared/widgets/scroll_view_column.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;
    final StackRouter router = context.router;

    return ScrollViewColumn(
      children: [
        const AccountOverviewCard(),
        const CustomDivider(),
        const LocationPickerCard(),
        const CustomDivider(height: 38),
        const CustomDivider(isTransparent: false),
        ListTile(
          leading: const Icon(Icons.person_outline),
          title: Text(l10n.account),
          onTap: () async => router.push(const AccountRoute()),
        ),
        /* TODO: make the page
        ListTile(
          leading: const Icon(Icons.analytics_outlined),
          title: Text(l10n.statistics),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const StatisticsScreen())),
        ),*/
        const CustomDivider(isTransparent: false),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: Text(l10n.settings),
          onTap: () async => router.push(const SettingsRoute()),
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: Text(l10n.about),
          onTap: () async => router.push(const AboutRoute()),
        ),
        ListTile(
          leading: const Icon(Icons.share_outlined),
          title: Text(l10n.shareApp),
          onTap: () async => Share.share(Links.autojidelna, subject: l10n.appName),
        ),
      ],
    );
  }
}
