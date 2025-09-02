import 'package:autojidelna/core/analytics/analytics_service.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/core/types/freezed/account/account.dart';
import 'package:autojidelna/features/onboarding/application/onboarding_providers.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:autojidelna/shared/snackbars/show_internet_connection_snack_bar.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class Onboarding {
  static Future<bool> login(BuildContext context, WidgetRef ref, FormKeys formKeyEnum) async {
    final formKey = ref.read(formKeyProvider(formKeyEnum));
    final disableInteractionsNotifier = ref.read(disableInteractions.notifier);

    if (!formKey.currentState!.validate()) return false;
    formKey.currentState!.save();

    for (OnboardingFields field in OnboardingFields.values) {
      ref.read(textFieldProvider(field).notifier).setError(null);
    }

    disableInteractionsNotifier.state = true;
    bool allowNextPage = false;

    final Account account = Account(
      username: ref.read(textFieldProvider(OnboardingFields.username)).value!,
      password: ref.read(textFieldProvider(OnboardingFields.password)).value!,
      url: ref.read(textFieldProvider(OnboardingFields.url)).value!,
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
          if (context.mounted && formKeyEnum == FormKeys.url) {
            ref.read(textFieldProvider(OnboardingFields.url).notifier).setError(context.l10n.errorsWrongUrl);
          }
          break;
        case AuthErrors.wrongCredentials:
          if (context.mounted && formKeyEnum == FormKeys.credentials) {
            ref.read(textFieldProvider(OnboardingFields.password).notifier).setError(context.l10n.errorsWrongCredentialsTextField);
          }
          if (formKeyEnum == FormKeys.url) allowNextPage = true;
          break;
        default:
      }
    }

    formKeyEnum == FormKeys.credentials
        ? Hive.box(Boxes.appState).put(HiveKeys.appState.url, ref.read(textFieldProvider(OnboardingFields.url)).value)
        : AnalyticsService.instance.logCanteenUrl(ref.read(textFieldProvider(OnboardingFields.url)).value!, ref.read(currentCanteen).verze);
    disableInteractionsNotifier.state = false;
    return allowNextPage;
  }
}
