import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/features/onboarding/application/step_flow_controller.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/src/_global/providers/account.provider.dart';
import 'package:autojidelna/src/_global/providers/canteen.provider.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/src/logic/show_snack_bar.dart';
import 'package:autojidelna/src/types/app_context.dart';
import 'package:autojidelna/src/types/errors.dart';
import 'package:autojidelna/src/ui/widgets/snackbars/show_internet_connection_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this.ref);
  Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    BuildContext? ctx = App.getIt<AppContext>().context;
    if (ctx == null) return;
    final UserProvider provider = ref.read(userProvider);
    final L10n lang = ctx.l10n;

    if (provider.user != null) {
      try {
        if (ctx.mounted) await ref.read(canteenProvider).preIndexMenus();
      } catch (_) {} // Just QoL
      return resolver.next(true); // if logged in during onboarding
    }

    try {
      await provider.loadUser();
      try {
        if (ctx.mounted) await ref.read(canteenProvider).preIndexMenus();
      } catch (_) {} // Just QoL
      resolver.next(true); // Allow navigation
    } catch (e) {
      switch (e) {
        case AuthErrors.accountNotSelected:
          showErrorSnackBar(SnackBarAuthErrors.accountNotFound(lang));
          break;
        case AuthErrors.connectionFailed:
          showErrorSnackBar(SnackBarAuthErrors.connectionFailed(lang));
          break;
        case AuthErrors.noInternetConnection:
          if (await showInternetConnectionSnackBar()) {
            onNavigation(resolver, router); // Retry login
            return;
          }
          break;
        case AuthErrors.wrongCredentials:
          showErrorSnackBar(SnackBarAuthErrors.wrongCredentials(lang));
          break;
        case AuthErrors.wrongUrl:
          showErrorSnackBar(SnackBarAuthErrors.wrongUrl(lang));
          break;
        default:
      }
      if (ctx.mounted) await provider.updateLoggedSafeAccounts();
      if (provider.loggedInAccounts.isNotEmpty) {
        StepFlowController.instance.setAccountPickerFlow();
        resolver.redirect(OnboardingRoute(onCompletedCallback: (_) => onNavigation(resolver, router)), replace: true);
        return;
      }
      StepFlowController.instance.setLoginFlow();
      resolver.redirect(OnboardingRoute(onCompletedCallback: resolver.next), replace: true);
    }
  }
}
