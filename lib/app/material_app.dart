import 'package:autojidelna/app/app_providers.dart';
import 'package:autojidelna/app/routing/app_router.dart';
import 'package:autojidelna/shared/localization/current_locale.dart';
import 'package:autojidelna/shared/monitoring/firebase_tab_observer.dart';
import 'package:autojidelna/shared/theme/app_themes.dart';
import 'package:autojidelna/shared/theme/application/theme_notifier.dart';
import 'package:autojidelna/shared/theme/domain/theme_state.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/utils/deep_link_transformer_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.read(appRouterProvider);
    final ThemeNotifier themeNotifier = ref.read(themeNotifierProvider.notifier);
    final ThemeState themeProvider = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: ref.read(scaffoldMessengerProvider),
      themeMode: themeProvider.themeMode,
      theme: AppThemes.theme(themeNotifier.colorSchemeLight()),
      darkTheme: AppThemes.theme(themeNotifier.colorSchemeDark(), amoledMode: themeProvider.amoledMode),
      locale: ref.watch(currentLocaleProvider),
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: L10n.localizationsDelegates,
      routerConfig: appRouter.config(
        includePrefixMatches: true,
        navigatorObservers: () => [FirebaseTabObserver()],
        deepLinkTransformer: (uri) async => deepLinkTransformer(uri),
      ),
    );
  }
}
