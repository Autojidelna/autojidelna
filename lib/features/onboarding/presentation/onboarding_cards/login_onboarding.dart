import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/remote-config/remote_config.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/core/types/freezed/account/account.dart';
import 'package:autojidelna/core/utils/url.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:autojidelna/shared/snackbars/show_internet_connection_snack_bar.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:autojidelna/features/onboarding/application/onboarding_providers.dart';
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginOnboarding extends ConsumerWidget implements OnboardingStep {
  const LoginOnboarding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: ref.read(formKeyProvider(FormKeys.credentials)),
        child: AutofillGroup(
          child: Column(
            children: [
              const _UrlListTile(),
              const CustomDivider(isTransparent: false),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                child: TextFormField(
                  controller: ref.watch(textFieldControllerProvider(OnboardingFields.username)),
                  autocorrect: false,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.username],
                  decoration: InputDecoration(
                    labelText: l10n.loginUserFieldLabel,
                    errorText: ref.watch(textFieldProvider(OnboardingFields.password)).error != null ? '' : null,
                  ),
                  onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  validator: (value) => (value?.isEmpty ?? true) ? l10n.loginUserFieldHint : null,
                  onSaved: ref.read(textFieldProvider(OnboardingFields.username).notifier).setValue,
                ),
              ),
              const CustomDivider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                child: TextFormField(
                  controller: ref.watch(textFieldControllerProvider(OnboardingFields.password)),
                  autocorrect: false,
                  obscureText: ref.watch(textFieldProvider(OnboardingFields.password)).obscureText,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  decoration: InputDecoration(
                    labelText: l10n.password,
                    errorText: ref.watch(textFieldProvider(OnboardingFields.password)).error,
                    suffixIcon: IconButton(
                      onPressed: ref.read(textFieldProvider(OnboardingFields.password).notifier).toggleObscure,
                      icon: Icon(ref.watch(textFieldProvider(OnboardingFields.password)).obscureText ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  validator: (value) => (value?.isEmpty ?? true) ? l10n.loginPasswordFieldHint : null,
                  onSaved: ref.read(textFieldProvider(OnboardingFields.password).notifier).setValue,
                ),
              ),
              const CustomDivider(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Future<bool> onPreviousPage(BuildContext context, WidgetRef ref) async => true;

  @override
  Future<bool> onNextPage(BuildContext context, WidgetRef ref) async {
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
      switch (e) {
        case AuthErrors.noInternetConnection:
          if (await showInternetConnectionSnackBar() && context.mounted) onNextPage(context, ref);
          break;
        case AuthErrors.wrongCredentials:
          if (context.mounted) ref.read(textFieldProvider(OnboardingFields.password).notifier).setError(context.l10n.errorsWrongCredentialsTextField);
          break;
        case AuthErrors.wrongUrl:
          break;
        default:
          showErrorSnackBar(SnackBarAuthErrors.connectionFailed(context.l10n));
      }
    }

    ref.read(disableInteractions.notifier).state = false;
    return allowNextPage;
  }

  @override
  String buttonText(BuildContext context) => context.l10n.login;

  @override
  String description(BuildContext context) => context.l10n.loginSubtitle;
}

class _UrlListTile extends ConsumerWidget {
  const _UrlListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? urlFieldValue = ref.read(textFieldProvider(OnboardingFields.url)).value;

    final Map<String, String> urls = Map<String, String>.from(ref.read(remoteConfigValues)[RemoteConfig.canteenUrls]);
    final MapEntry<String, String> url = urls.entries.firstWhere(
      (e) => e.value == urlFieldValue,
      orElse: () => MapEntry(Url.clean(urlFieldValue!).split('.').reversed.elementAt(1), urlFieldValue),
    );

    return ListTile(title: Text(url.key), subtitle: Text(url.value));
  }
}
