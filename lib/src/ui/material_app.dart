import 'dart:async';

import 'package:autojidelna/src/_conf/hive.dart';
import 'package:autojidelna/src/_global/app.dart';
import 'package:autojidelna/src/_global/providers/account.provider.dart';
import 'package:autojidelna/src/_global/providers/analytics.provider.dart';
import 'package:autojidelna/src/_global/providers/canteen.provider.dart';
import 'package:autojidelna/src/_global/providers/settings.provider.dart';
import 'package:autojidelna/src/_global/riverpod/theme/theme.riverpod.dart';
import 'package:autojidelna/src/_sentry/sentry.dart';
import 'package:autojidelna/src/lang/l10n_context_extension.dart';
import 'package:autojidelna/src/_routing/app_router.dart';
import 'package:autojidelna/src/logic/deep_link_transformer_logic.dart';
import 'package:autojidelna/src/types/app_context.dart';
import 'package:autojidelna/src/types/freezed/theme_state/theme_state.dart';
import 'package:autojidelna/src/ui/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState() {
    initLocale();
    super.initState();
  }

  void initLocale() {
    if (Texts.supportedLocales.contains(App.currentLocale)) {
      if (_locale == null) unawaited(Hive.box(Boxes.appState).put(HiveKeys.appState.locale, App.currentLocale.languageCode));
      _locale ??= App.currentLocale;
    } else {
      if (_locale == null) unawaited(Hive.box(Boxes.appState).put(HiveKeys.appState.locale, App.defaultLocale.languageCode));
      _locale ??= App.defaultLocale;
      if (_locale == null) App.currentLocale = App.defaultLocale;
    }
    App.translate = _onTranslatedLanguage;
  }

  void _onTranslatedLanguage(Locale? locale) {
    locale ??= App.defaultLocale;
    unawaited(Hive.box(Boxes.appState).put(HiveKeys.appState.locale, locale.languageCode));
    App.currentLocale = locale;
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = App.getIt<AppRouter>();

    return riverpod.Consumer(
      builder: (context, ref, child) {
        final ThemeNotifier themeNotifier = ref.read(themeNotifierProvider.notifier);
        final ThemeState themeProvider = ref.watch(themeNotifierProvider);

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: AppThemes.theme(themeNotifier.colorSchemeLight()),
          darkTheme: AppThemes.theme(themeNotifier.colorSchemeDark(), amoledMode: themeProvider.amoledMode),
          locale: _locale,
          supportedLocales: Texts.supportedLocales,
          localizationsDelegates: Texts.localizationsDelegates,
          routerConfig: appRouter.config(
            includePrefixMatches: true,
            navigatorObservers: () => [SentryNavigatorObserver(), SentryTabObserver()],
            deepLinkTransformer: (uri) async => deepLinkTransformer(uri),
            placeholder: (context) {
              App.getIt<AppContext>().setContext(context);
              return child!;
            },
          ),
        );
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}

class MyAppWrapper extends riverpod.ConsumerWidget {
  const MyAppWrapper({super.key});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: App.remoteConfigProvider),
          ChangeNotifierProvider.value(value: ref.watch(userProvider.notifier)),
          ChangeNotifierProvider.value(value: ref.watch(canteenProvider.notifier)),
          ChangeNotifierProvider.value(value: ref.watch(analyticsProvider.notifier)),
          ChangeNotifierProvider.value(value: ref.watch(settings.notifier)),
        ],
        child: const MyApp(),
      );
}
