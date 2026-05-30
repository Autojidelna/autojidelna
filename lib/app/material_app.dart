import 'package:autojidelna/app/app_providers.dart';
import 'package:autojidelna/app/routing/app_router.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/utils/deep_link_transformer_logic.dart';
import 'package:autojidelna/shared/localization/current_locale.dart';
import 'package:autojidelna/shared/theme/app_themes.dart';
import 'package:autojidelna/shared/theme/application/theme_notifier.dart';
import 'package:autojidelna/shared/theme/domain/theme_state.dart';
import 'package:autojidelna/features/splash_screen/splash_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.read(appRouterProvider);
    final ThemeNotifier themeNotifier = ref.read(themeProvider.notifier);
    final ThemeState themeState = ref.watch(themeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: ref.read(scaffoldMessengerProvider),
      themeMode: themeState.themeMode,
      theme: AppThemes.theme(themeNotifier.colorSchemeLight()),
      darkTheme: AppThemes.theme(themeNotifier.colorSchemeDark(), amoledMode: themeState.amoledMode),
      locale: ref.watch(currentLocaleProvider),
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: L10n.localizationsDelegates,
      routerConfig: appRouter.config(
        includePrefixMatches: true,
        deepLinkTransformer: deepLinkTransformer,
        placeholder: (context) => const SplashPage(),
      ),
    );
  }
}
