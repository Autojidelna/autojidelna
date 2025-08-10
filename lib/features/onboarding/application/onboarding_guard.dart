import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/features/onboarding/application/step_flow_controller.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class OnboardingGuard extends AutoRouteGuard {
  OnboardingGuard(this.ref);
  final Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    bool isFirstTime = Hive.box(Boxes.appState).get(HiveKeys.appState.firstTime, defaultValue: true);

    if (!isFirstTime) {
      resolver.next(true); // Allow navigation
      return;
    }

    final stepFlow = StepFlowController.instance..reset();

    await ref.read(userProvider).updateLoggedSafeAccounts();
    int loggedInAccounts = ref.read(userProvider).loggedInAccounts.length;

    if (loggedInAccounts > 1) {
      stepFlow.addSteps(stepFlow.accountPickerFlowPages);
    } else if (1 > loggedInAccounts) {
      stepFlow.addSteps(stepFlow.loginFlowPage);
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
