import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/app/app_providers.dart';
import 'package:autojidelna/app/routing/app_router.dart';
import 'package:autojidelna/shared/theme/app_themes.dart';
import 'package:autojidelna/shared/theme/application/theme_notifier.dart';
import 'package:autojidelna/shared/theme/domain/theme_state.dart';
import 'package:autojidelna/src/_global/providers/account.provider.dart';
import 'package:autojidelna/src/_global/providers/canteen.provider.dart';
import 'package:autojidelna/shared/monitoring/sentry_tab_observer.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/src/logic/deep_link_transformer_logic.dart';
import 'package:autojidelna/src/types/app_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as prov;
import 'package:sentry_flutter/sentry_flutter.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.read(appRouterProvider);
    final ThemeNotifier themeNotifier = ref.read(themeNotifierProvider.notifier);
    final ThemeState themeProvider = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: AppThemes.theme(themeNotifier.colorSchemeLight()),
      darkTheme: AppThemes.theme(themeNotifier.colorSchemeDark(), amoledMode: themeProvider.amoledMode),
      locale: ref.watch(currentLocaleProvider),
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: L10n.localizationsDelegates,
      routerConfig: appRouter.config(
        includePrefixMatches: true,
        navigatorObservers: () => [SentryNavigatorObserver(), SentryTabObserver()],
        deepLinkTransformer: (uri) async => deepLinkTransformer(uri),
        placeholder: (context) {
          App.getIt<AppContext>().setContext(context);
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

class MyAppWrapper extends ConsumerWidget {
  const MyAppWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => prov.MultiProvider(
        providers: [
          prov.ChangeNotifierProvider.value(value: ref.watch(userProvider.notifier)),
          prov.ChangeNotifierProvider.value(value: ref.watch(canteenProvider.notifier)),
        ],
        child: const MyApp(),
      );
}
