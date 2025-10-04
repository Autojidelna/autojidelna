import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/shared/providers/saved_accounts.dart';
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';
import 'package:autojidelna/features/onboarding/onboarding.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@Dependencies([onboardingFormKey, OnboardingTextFieldState, OnboardingSteps, OnboardingFocusNodeFocus])
class OnboardingGuard extends AutoRouteGuard {
  OnboardingGuard(this.ref);
  final Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    bool isFirstTime = Hive.box(Boxes.appState).get(HiveKeys.appState.firstTime, defaultValue: true);

    // Don't guard the onboarding route itself
    if (resolver.route.name == OnboardingRoute.name || !isFirstTime) {
      resolver.next(true);
      return;
    }

    List<OnboardingStep> steps = Onboarding.defaultSteps;
    if ((await ref.read(savedAccountsProvider.future)).isNotEmpty) {
      steps.addAll(Onboarding.accountPickerSteps);
    } else {
      steps.addAll(Onboarding.loginSteps);
    }

    resolver.redirectUntil(
      OnboardingRoute(
        steps: steps,
        onCompletedCallback: (onSuccess) async {
          Hive.box(Boxes.appState).put(HiveKeys.appState.firstTime, !onSuccess);
          resolver.next(onSuccess);
        },
      ),
    );
  }
}
