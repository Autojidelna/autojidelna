import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/app/app_providers.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/shared/config/assets.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/src/logic/about_app_button_logic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutAppButton extends ConsumerWidget {
  const AboutAppButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = context.l10n;
    PackageInfo? packageInfo = ref.read(packageInfoProvider)!;
    int? currentPatchNumber = ref.read(currentPatchNumberProvider);

    return IconButton(
      icon: const Icon(Icons.info_outline),
      onPressed: () => showAboutDialog(
        context: context,
        applicationName: lang.appName,
        applicationVersion:
            '${packageInfo.version} (${packageInfo.buildNumber})${kDebugMode ? lang.debug : ''}${currentPatchNumber != null ? ' - ${lang.patch} $currentPatchNumber' : ''}',
        applicationIcon: GestureDetector(
          onTap: appElevateClick,
          child: Image.asset(
            Assets.icon,
            width: 54,
          ),
        ),
        children: [
          Text(lang.appDescription),
          GestureDetector(
            onTap: appElevateClick,
            onLongPress: () async {
              context.router.push(const DebugRoute());
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 27.01),
              child: Image.asset(Assets.appElevateLogo),
            ),
          ),
        ],
      ),
    );
  }
}
