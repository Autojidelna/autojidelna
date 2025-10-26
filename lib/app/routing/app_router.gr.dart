// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:autojidelna/dev/presentation/debug_page.dart' as _i6;
import 'package:autojidelna/features/about/about_page.dart' as _i1;
import 'package:autojidelna/features/app/router_page.dart' as _i11;
import 'package:autojidelna/features/auth/presentation/account_page.dart'
    as _i2;
import 'package:autojidelna/features/canteen/presentation/pages/dish_detail_page.dart'
    as _i7;
import 'package:autojidelna/features/canteen/presentation/pages/menu_page.dart'
    as _i8;
import 'package:autojidelna/features/more/presentation/more_page.dart' as _i9;
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart'
    as _i18;
import 'package:autojidelna/features/onboarding/presentation/onboarding_page.dart'
    as _i10;
import 'package:autojidelna/features/settings/presentation/pages/analytics_page.dart'
    as _i3;
import 'package:autojidelna/features/settings/presentation/pages/appearance_page.dart'
    as _i4;
import 'package:autojidelna/features/settings/presentation/pages/convenience_page.dart'
    as _i5;
import 'package:autojidelna/features/settings/presentation/pages/settings_page.dart'
    as _i12;
import 'package:autojidelna/features/splash_screen/splash_page.dart' as _i13;
import 'package:autojidelna/features/statistics/presentation/statistics_page.dart'
    as _i14;
import 'package:collection/collection.dart' as _i19;
import 'package:flutter/material.dart' as _i16;
import 'package:icanteenlib/canteenlib.dart' as _i17;

/// generated route for
/// [_i1.AboutPage]
class AboutRoute extends _i15.PageRouteInfo<void> {
  const AboutRoute({List<_i15.PageRouteInfo>? children})
    : super(AboutRoute.name, initialChildren: children);

  static const String name = 'AboutRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i1.AboutPage();
    },
  );
}

/// generated route for
/// [_i2.AccountPage]
class AccountRoute extends _i15.PageRouteInfo<void> {
  const AccountRoute({List<_i15.PageRouteInfo>? children})
    : super(AccountRoute.name, initialChildren: children);

  static const String name = 'AccountRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.AccountPage();
    },
  );
}

/// generated route for
/// [_i3.AnalyticsPage]
class AnalyticsRoute extends _i15.PageRouteInfo<void> {
  const AnalyticsRoute({List<_i15.PageRouteInfo>? children})
    : super(AnalyticsRoute.name, initialChildren: children);

  static const String name = 'AnalyticsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i3.AnalyticsPage();
    },
  );
}

/// generated route for
/// [_i4.AppearancePage]
class AppearanceRoute extends _i15.PageRouteInfo<void> {
  const AppearanceRoute({List<_i15.PageRouteInfo>? children})
    : super(AppearanceRoute.name, initialChildren: children);

  static const String name = 'AppearanceRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i4.AppearancePage();
    },
  );
}

/// generated route for
/// [_i5.ConveniencePage]
class ConvenienceRoute extends _i15.PageRouteInfo<void> {
  const ConvenienceRoute({List<_i15.PageRouteInfo>? children})
    : super(ConvenienceRoute.name, initialChildren: children);

  static const String name = 'ConvenienceRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i5.ConveniencePage();
    },
  );
}

/// generated route for
/// [_i6.DebugPage]
class DebugRoute extends _i15.PageRouteInfo<void> {
  const DebugRoute({List<_i15.PageRouteInfo>? children})
    : super(DebugRoute.name, initialChildren: children);

  static const String name = 'DebugRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i6.DebugPage();
    },
  );
}

/// generated route for
/// [_i7.DishDetailPage]
class DishDetailRoute extends _i15.PageRouteInfo<DishDetailRouteArgs> {
  DishDetailRoute({
    _i16.Key? key,
    required _i17.Jidlo dish,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         DishDetailRoute.name,
         args: DishDetailRouteArgs(key: key, dish: dish),
         initialChildren: children,
       );

  static const String name = 'DishDetailRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DishDetailRouteArgs>();
      return _i7.DishDetailPage(key: args.key, dish: args.dish);
    },
  );
}

class DishDetailRouteArgs {
  const DishDetailRouteArgs({this.key, required this.dish});

  final _i16.Key? key;

  final _i17.Jidlo dish;

  @override
  String toString() {
    return 'DishDetailRouteArgs{key: $key, dish: $dish}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DishDetailRouteArgs) return false;
    return key == other.key && dish == other.dish;
  }

  @override
  int get hashCode => key.hashCode ^ dish.hashCode;
}

/// generated route for
/// [_i8.MenuPage]
class MenuRoute extends _i15.PageRouteInfo<void> {
  const MenuRoute({List<_i15.PageRouteInfo>? children})
    : super(MenuRoute.name, initialChildren: children);

  static const String name = 'MenuRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i8.MenuPage();
    },
  );
}

/// generated route for
/// [_i9.MorePage]
class MoreRoute extends _i15.PageRouteInfo<void> {
  const MoreRoute({List<_i15.PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i9.MorePage();
    },
  );
}

/// generated route for
/// [_i10.OnboardingPage]
class OnboardingRoute extends _i15.PageRouteInfo<OnboardingRouteArgs> {
  OnboardingRoute({
    _i16.Key? key,
    List<_i18.OnboardingStep>? steps,
    void Function(bool)? onCompletedCallback,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         OnboardingRoute.name,
         args: OnboardingRouteArgs(
           key: key,
           steps: steps,
           onCompletedCallback: onCompletedCallback,
         ),
         initialChildren: children,
       );

  static const String name = 'OnboardingRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingRouteArgs>(
        orElse: () => const OnboardingRouteArgs(),
      );
      return _i10.OnboardingPage(
        key: args.key,
        steps: args.steps,
        onCompletedCallback: args.onCompletedCallback,
      );
    },
  );
}

class OnboardingRouteArgs {
  const OnboardingRouteArgs({this.key, this.steps, this.onCompletedCallback});

  final _i16.Key? key;

  final List<_i18.OnboardingStep>? steps;

  final void Function(bool)? onCompletedCallback;

  @override
  String toString() {
    return 'OnboardingRouteArgs{key: $key, steps: $steps, onCompletedCallback: $onCompletedCallback}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OnboardingRouteArgs) return false;
    return key == other.key &&
        const _i19.ListEquality<_i18.OnboardingStep>().equals(
          steps,
          other.steps,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^ const _i19.ListEquality<_i18.OnboardingStep>().hash(steps);
}

/// generated route for
/// [_i11.RouterPage]
class RouterRoute extends _i15.PageRouteInfo<void> {
  const RouterRoute({List<_i15.PageRouteInfo>? children})
    : super(RouterRoute.name, initialChildren: children);

  static const String name = 'RouterRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i11.RouterPage();
    },
  );
}

/// generated route for
/// [_i12.SettingsPage]
class SettingsRoute extends _i15.PageRouteInfo<void> {
  const SettingsRoute({List<_i15.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i12.SettingsPage();
    },
  );
}

/// generated route for
/// [_i13.SplashPage]
class SplashRoute extends _i15.PageRouteInfo<void> {
  const SplashRoute({List<_i15.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i13.SplashPage();
    },
  );
}

/// generated route for
/// [_i14.StatisticsPage]
class StatisticsRoute extends _i15.PageRouteInfo<void> {
  const StatisticsRoute({List<_i15.PageRouteInfo>? children})
    : super(StatisticsRoute.name, initialChildren: children);

  static const String name = 'StatisticsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i14.StatisticsPage();
    },
  );
}
