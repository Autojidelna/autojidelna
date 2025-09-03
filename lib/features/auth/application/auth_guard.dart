import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/features/onboarding/onboarding.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/shared/localization/current_locale.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/features/canteen/application/canteen.provider.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/shared/snackbars/show_internet_connection_snack_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this.ref);
  Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final UserProvider provider = ref.read(userProvider);
    final L10n l10n = lookupL10n(ref.read(currentLocaleProvider));

    if (provider.user != null) {
      try {
        await ref.read(canteenProvider).preIndexMenus();
      } catch (_) {} // Just QoL
      return resolver.next(true); // if logged in during onboarding
    }

    try {
      await provider.loadUser();
      try {
        await ref.read(canteenProvider).preIndexMenus();
      } catch (_) {} // Just QoL
      resolver.next(true); // Allow navigation
    } catch (e) {
      switch (e) {
        case AuthErrors.accountNotSelected:
          showErrorSnackBar(SnackBarAuthErrors.accountNotFound(l10n));
          break;
        case AuthErrors.connectionFailed:
          showErrorSnackBar(SnackBarAuthErrors.connectionFailed(l10n));
          break;
        case AuthErrors.noInternetConnection:
          if (await showInternetConnectionSnackBar()) {
            onNavigation(resolver, router); // Retry login
            return;
          }
          break;
        case AuthErrors.wrongCredentials:
          showErrorSnackBar(SnackBarAuthErrors.wrongCredentials(l10n));
          break;
        case AuthErrors.wrongUrl:
          showErrorSnackBar(SnackBarAuthErrors.wrongUrl(l10n));
          break;
        default:
      }
      await provider.updateLoggedSafeAccounts();
      if (provider.loggedInAccounts.isNotEmpty) {
        ref.read(onboardingPagesProvider.notifier).setAccountPickerFlow();
        resolver.redirect(OnboardingRoute(onCompletedCallback: resolver.next), replace: true);
        return;
      }
      ref.read(onboardingPagesProvider.notifier).setLoginFlow();
      resolver.redirect(OnboardingRoute(onCompletedCallback: resolver.next), replace: true);
    }
  }
}
