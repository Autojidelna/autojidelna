import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/features/onboarding/application/onboarding_guard.dart';
import 'package:autojidelna/src/_routing/app_router.gr.dart';
import 'package:autojidelna/src/_routing/guards/auth_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter(ref));

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter(this.ref);
  Ref ref;

  @override
  RouteType get defaultRouteType => RouteType.custom(
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: Durations.short3.inMilliseconds,
        reverseDurationInMilliseconds: Durations.short3.inMilliseconds,
      );

  @override
  List<AutoRouteGuard> get guards => [OnboardingGuard(ref), AuthGuard()];

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: RouterPage.page,
          path: '/',
          initial: true,
          children: <AutoRoute>[
            AutoRoute(page: MenuPage.page, path: 'menu', initial: true),
            AutoRoute(page: MorePage.page, path: 'more'),
          ],
        ),
        AutoRoute(page: OnboardingPage.page, path: '/welcome'),
        AutoRoute(page: DishDetailPage.page, path: '/detail'),
        AutoRoute(page: AccountPage.page, path: '/account'),
        AutoRoute(page: StatisticsPage.page, path: '/statistics'),
        AutoRoute(page: SettingsPage.page, path: '/settings'),
        AutoRoute(page: AnalyticsPage.page, path: '/settings/analytics'),
        AutoRoute(page: AppearancePage.page, path: '/settings/appearance'),
        AutoRoute(page: ConveniencePage.page, path: '/settings/convenience'),
        AutoRoute(page: AboutPage.page, path: '/about'),
        AutoRoute(page: DebugPage.page, path: '/demo/debug'),
        RedirectRoute(path: '*', redirectTo: '/'),
      ];
}
