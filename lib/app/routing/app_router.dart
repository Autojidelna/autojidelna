import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/features/onboarding/application/onboarding_guard.dart';
import 'package:autojidelna/features/auth/application/auth_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter(ref));

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter(this.ref) : super(navigatorKey: App.navigatorKey);
  Ref ref;

  @override
  RouteType get defaultRouteType =>
      RouteType.custom(transitionsBuilder: TransitionsBuilders.fadeIn, duration: Durations.short3, reverseDuration: Durations.short3);

  @override
  List<AutoRouteGuard> get guards => [OnboardingGuard(ref)];

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: RouterRoute.page,
      path: '/',
      initial: true,
      guards: [AuthGuard(ref)],
      children: <AutoRoute>[
        AutoRoute(page: MenuRoute.page, path: 'menu', initial: true),
        AutoRoute(page: MoreRoute.page, path: 'more'),
      ],
    ),
    AutoRoute(page: OnboardingRoute.page, path: '/welcome'),
    AutoRoute(page: DishDetailRoute.page, path: '/detail'),
    AutoRoute(page: AccountRoute.page, path: '/account'),
    AutoRoute(page: SettingsRoute.page, path: '/settings'),
    AutoRoute(page: AppearanceRoute.page, path: '/settings/appearance'),
    AutoRoute(page: ConvenienceRoute.page, path: '/settings/convenience'),
    AutoRoute(page: AboutRoute.page, path: '/about'),
    AutoRoute(page: DebugRoute.page, path: '/demo/debug'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}
