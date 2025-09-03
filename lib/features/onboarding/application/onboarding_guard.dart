import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/features/onboarding/onboarding.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class OnboardingGuard extends AutoRouteGuard {
  OnboardingGuard(this.ref);
  final Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // Don't guard the onboarding route itself
    if (resolver.route.name == OnboardingRoute.name) {
      resolver.next(true);
      return;
    }

    bool isFirstTime = Hive.box(Boxes.appState).get(HiveKeys.appState.firstTime, defaultValue: true);

    if (!isFirstTime) {
      resolver.next(true); // Allow navigation
      return;
    }

    await ref.read(userProvider).updateLoggedSafeAccounts();
    List<SafeAccount> loggedInAccounts = ref.read(userProvider).loggedInAccounts;

    final onboardingPagesNotifier = ref.read(onboardingPagesProvider.notifier);
    onboardingPagesNotifier.reset();

    if (loggedInAccounts.isNotEmpty) {
      onboardingPagesNotifier.addAccountPickerPages();
    } else {
      onboardingPagesNotifier.addLoginPages();
    }

    resolver.redirect(
      OnboardingRoute(
        onCompletedCallback: (onSuccess) async {
          Hive.box(Boxes.appState).put(HiveKeys.appState.firstTime, !onSuccess);
          resolver.next(onSuccess);
        },
      ),
    );
  }
}
