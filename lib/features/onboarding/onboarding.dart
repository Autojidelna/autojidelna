import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/analytics/analytics_service.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/core/types/freezed/account/account.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:autojidelna/shared/snackbars/show_internet_connection_snack_bar.dart';
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';
import 'package:autojidelna/features/onboarding/application/onboarding_providers.dart';
import 'package:autojidelna/features/onboarding/presentation/onboarding_cards/account_picker_onboarding.dart';
import 'package:autojidelna/features/onboarding/presentation/onboarding_cards/canteen_url_onboarding.dart';
import 'package:autojidelna/features/onboarding/presentation/onboarding_cards/login_onboarding.dart';
import 'package:autojidelna/features/onboarding/presentation/onboarding_cards/permissions_onboarding.dart';
import 'package:autojidelna/features/onboarding/presentation/onboarding_cards/theme_onboarding.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';

// ignore: provider_dependencies
class Onboarding {
  static late PageController pageController;

  static final List<OnboardingStep> defaultSteps = [
    const ThemeOnboarding(),
    const PermissionsOnboarding(),
  ];

  static final List<OnboardingStep> loginSteps = [
    const CanteenUrlOnboarding(),
    const LoginOnboarding(),
  ];

  static final List<OnboardingStep> accountPickerSteps = [
    const AccountPickerOnboarding(),
  ];

  static void nextPage() async {
    pageController.nextPage(
      duration: Durations.medium1,
      curve: Curves.easeInOut,
    );
  }

  static void previousPage() async {
    pageController.previousPage(
      duration: Durations.medium1,
      curve: Curves.easeInOut,
    );
  }

  static Future<bool> login(BuildContext context, WidgetRef ref, OnboardingFormKeys formKeyEnum) async {
    final formKey = ref.read(onboardingFormKeyProvider(formKeyEnum));
    final disableInteractionsNotifier = ref.read(disableInteractions.notifier);

    if (!formKey.currentState!.validate()) return false;
    formKey.currentState!.save();

    for (OnboardingTextFields field in OnboardingTextFields.values) {
      ref.read(onboardingTextFieldStateProvider(field).notifier).setError(null);
    }

    disableInteractionsNotifier.state = true;
    bool allowNextPage = false;

    String url = ref.read(onboardingTextFieldStateProvider(OnboardingTextFields.url)).value ?? '';

    final Account account = Account(
      username: ref.read(onboardingTextFieldStateProvider(OnboardingTextFields.username)).value ?? '',
      password: ref.read(onboardingTextFieldStateProvider(OnboardingTextFields.password)).value ?? '',
      url: url,
    );

    try {
      await ref.read(userProvider).login(account);
      allowNextPage = true;
    } catch (e) {
      switch (e) {
        case AuthErrors.noInternetConnection:
          if (await showInternetConnectionSnackBar() && context.mounted) login(context, ref, formKeyEnum);
          break;
        case AuthErrors.connectionFailed:
          if (context.mounted) showErrorSnackBar(SnackBarAuthErrors.connectionFailed(context.l10n));
          break;
        case AuthErrors.wrongUrl:
          if (context.mounted && formKeyEnum == OnboardingFormKeys.url) {
            ref.read(onboardingTextFieldStateProvider(OnboardingTextFields.url).notifier).setError(context.l10n.errorsWrongUrl);
          }
          break;
        case AuthErrors.wrongCredentials:
          if (context.mounted && formKeyEnum == OnboardingFormKeys.credentials) {
            ref.read(onboardingTextFieldStateProvider(OnboardingTextFields.password).notifier).setError(context.l10n.errorsWrongCredentialsTextField);
          }
          if (formKeyEnum == OnboardingFormKeys.url) allowNextPage = true;
          break;
        default:
      }
    }

    formKeyEnum == OnboardingFormKeys.credentials
        ? Hive.box(Boxes.appState).put(HiveKeys.appState.url, url)
        : AnalyticsService.instance.logCanteenUrl(url, ref.read(currentCanteen).verze);
    disableInteractionsNotifier.state = false;
    return allowNextPage;
  }
}
