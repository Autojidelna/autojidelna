import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/app/app_providers.dart';
import 'package:autojidelna/shared/config/assets.dart';
import 'package:autojidelna/shared/config/links.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:autojidelna/shared/widgets/scroll_view_column.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n l10n = context.l10n;

    final AsyncValue<PackageInfo> packageInfo = ref.watch(packageInfoProvider);
    String version = '';

    if (packageInfo.hasValue) {
      version = packageInfo.value!.version;
    }
    String appVersion = l10n.versionSubtitle(kDebugMode.toString(), version);

    Widget logo = SvgPicture.asset(
      Assets.logo,
      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
      height: MediaQuery.sizeOf(context).height * .10,
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.about)),
      body: ScrollViewColumn(
        children: [
          // logo
          Padding(padding: const EdgeInsets.symmetric(vertical: 85.0), child: logo),
          const CustomDivider(isTransparent: false),
          // version list tile
          ListTile(
            title: Text(l10n.version),
            subtitle: Text(appVersion),
          ),
          // licenses list tile
          ListTile(
            title: Text(l10n.licenses),
            onTap: () => unawaited(
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LicensePage(
                    applicationName: l10n.appName,
                    applicationVersion: appVersion,
                    applicationIcon: logo,
                    applicationLegalese: l10n.appLegalese(DateTime.now()),
                  ),
                ),
              ),
            ),
          ),
          // privacy policy
          ListTile(
            title: Text(l10n.privacyPolicy),
            onTap: () => unawaited(launchUrl(Uri.parse(Links.privacyPolicy))),
          ),
          const CustomDivider(isTransparent: false),
          // links
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => unawaited(launchUrl(Uri.parse(Links.autojidelna))),
                icon: const Icon(Icons.public_outlined),
              ),
              IconButton(
                onPressed: () => unawaited(launchUrl(Uri.parse(Links.repo))),
                icon: const Icon(OctIcons.mark_github_24),
              ),
              /*IconButton(
                onPressed: () => unawaited(launchUrl(Uri(scheme: 'mailto', path: Links.email))),
                icon: const Icon(Icons.email_outlined),
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}
