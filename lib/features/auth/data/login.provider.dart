import 'package:autojidelna/features/onboarding/application/onboarding_providers.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/core/types/freezed/account/account.dart';
import 'package:autojidelna/shared/snackbars/show_internet_connection_snack_bar.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = ChangeNotifierProvider<LoginProvider>((ref) => LoginProvider(ref));

class LoginProvider extends ChangeNotifier {
  Ref ref;

  LoginProvider(this.ref);

  Future<bool> login(BuildContext context) async {
    final formKey = ref.read(formKeyProvider(FormKeys.credentials));
    final disableInteractionsNotifier = ref.read(disableInteractions.notifier);

    if (!formKey.currentState!.validate()) return false;
    formKey.currentState!.save();

    for (var field in OnboardingFields.values) {
      ref.read(textFieldProvider(field).notifier).setError(null);
    }

    disableInteractionsNotifier.state = true;
    bool allowNextPage = false;

    final account = Account(
      username: ref.read(textFieldProvider(OnboardingFields.username)).value!,
      password: ref.read(textFieldProvider(OnboardingFields.password)).value!,
      url: ref.read(textFieldProvider(OnboardingFields.url)).value!,
    );

    try {
      await ref.read(userProvider).login(account);
      allowNextPage = true;
    } catch (e) {
      if (context.mounted) handleAuthError(context, e);
    }

    ref.read(disableInteractions.notifier).state = false;
    return allowNextPage;
  }

  void handleAuthError(BuildContext context, dynamic e) async {
    final l10n = context.l10n;
    switch (e) {
      case AuthErrors.noInternetConnection:
        if (await showInternetConnectionSnackBar() && context.mounted) login(context);
        break;
      case AuthErrors.wrongCredentials:
        ref.read(textFieldProvider(OnboardingFields.password).notifier).setError(l10n.errorsWrongCredentialsTextField);
        break;
      case AuthErrors.wrongUrl:
        break;
      default:
        showErrorSnackBar(SnackBarAuthErrors.connectionFailed(l10n));
    }
  }
}
