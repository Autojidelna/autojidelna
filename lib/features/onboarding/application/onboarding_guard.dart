import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/features/onboarding/application/step_flow_controller.dart';
import 'package:autojidelna/src/_conf/hive.dart';
import 'package:autojidelna/src/_global/app.dart';
import 'package:autojidelna/src/_global/providers/account.provider.dart';
import 'package:autojidelna/src/_routing/app_router.gr.dart';
import 'package:autojidelna/src/types/app_context.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class OnboardingGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    bool isFirstTime = Hive.box(Boxes.appState).get(HiveKeys.appState.firstTime, defaultValue: true);

    if (isFirstTime) {
      final stepFlow = StepFlowController.instance..reset();
      BuildContext? ctx = App.getIt<AppContext>().context;

      if (ctx == null || !ctx.mounted) return;
      await ctx.read<UserProvider>().updateLoggedSafeAccounts();
      if (!ctx.mounted) return;
      int loggedInAccounts = ctx.read<UserProvider>().loggedInAccounts.length;

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
