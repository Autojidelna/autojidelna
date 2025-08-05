import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/features/onboarding/application/step_flow_controller.dart';
import 'package:autojidelna/src/_conf/hive.dart';
import 'package:autojidelna/src/_global/providers/account.provider.dart';
import 'package:autojidelna/src/_routing/app_router.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class OnboardingGuard extends AutoRouteGuard {
  OnboardingGuard(this.ref);
  final Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    bool isFirstTime = Hive.box(Boxes.appState).get(HiveKeys.appState.firstTime, defaultValue: true);

    if (isFirstTime) {
      final stepFlow = StepFlowController.instance..reset();

      await ref.read(userProvider).updateLoggedSafeAccounts();
      int loggedInAccounts = ref.read(userProvider).loggedInAccounts.length;

      if (loggedInAccounts > 1) {
        stepFlow.pages.addAll(stepFlow.accountPickerFlowPages);
      } else if (1 > loggedInAccounts) {
        stepFlow.pages.addAll(stepFlow.accountPickerFlowPages);
      }

      resolver.redirect(
        OnboardingPage(
          onCompletedCallback: (onSuccess) async {
            Hive.box(Boxes.appState).put(HiveKeys.appState.firstTime, !onSuccess);
            resolver.next(onSuccess);
          },
        ),
      );
    } else {
      resolver.next(true); // Allow navigation
    }
  }
}
