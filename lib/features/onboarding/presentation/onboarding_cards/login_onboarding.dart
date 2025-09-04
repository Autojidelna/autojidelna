import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/remote-config/remote_config.dart';
import 'package:autojidelna/core/utils/url.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:autojidelna/features/onboarding/onboarding.dart';
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';
import 'package:autojidelna/features/onboarding/application/onboarding_providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginOnboarding extends ConsumerWidget implements OnboardingStep {
  const LoginOnboarding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n l10n = context.l10n;

    final usernameNotifier = ref.read(onboardingTextFieldStateProvider(OnboardingTextFields.username).notifier);
    final passwordNotifier = ref.read(onboardingTextFieldStateProvider(OnboardingTextFields.password).notifier);
    final passwordProvider = ref.watch(onboardingTextFieldStateProvider(OnboardingTextFields.password));

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: ref.read(onboardingFormKeyProvider(OnboardingFormKeys.credentials)),
        child: AutofillGroup(
          child: Column(
            children: [
              const _UrlListTile(),
              const CustomDivider(isTransparent: false),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                child: TextFormField(
                  controller: ref.watch(onboardingTextFieldControllerProvider(OnboardingTextFields.username)),
                  focusNode: ref.watch(onboardingFocusNodeProvider(OnboardingTextFields.username)),
                  autocorrect: false,
                  enabled: !ref.watch(disableInteractions),
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.username],
                  decoration: InputDecoration(
                    labelText: l10n.loginUserFieldLabel,
                    errorText: passwordProvider.error != null ? '' : null,
                  ),
                  onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  validator: (value) => (value?.isEmpty ?? true) ? l10n.loginUserFieldHint : null,
                  onSaved: usernameNotifier.setValue,
                ),
              ),
              const CustomDivider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                child: TextFormField(
                  controller: ref.watch(onboardingTextFieldControllerProvider(OnboardingTextFields.password)),
                  focusNode: ref.watch(onboardingFocusNodeProvider(OnboardingTextFields.password)),
                  autocorrect: false,
                  enabled: !ref.watch(disableInteractions),
                  obscureText: passwordProvider.obscureText,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  decoration: InputDecoration(
                    labelText: l10n.password,
                    errorText: passwordProvider.error,
                    suffixIcon: IconButton(
                      onPressed: passwordNotifier.toggleObscure,
                      icon: Icon(passwordProvider.obscureText ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  validator: (value) => (value?.isEmpty ?? true) ? l10n.loginPasswordFieldHint : null,
                  onSaved: passwordNotifier.setValue,
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
  Future<bool> onPreviousPage(BuildContext context, WidgetRef ref) async {
    ref.invalidate(onboardingFormKeyProvider(OnboardingFormKeys.credentials));
    ref.invalidate(onboardingTextFieldControllerProvider(OnboardingTextFields.username));
    ref.invalidate(onboardingTextFieldControllerProvider(OnboardingTextFields.password));
    ref.invalidate(onboardingTextFieldStateProvider(OnboardingTextFields.username));
    ref.invalidate(onboardingTextFieldStateProvider(OnboardingTextFields.password));
    return true;
  }

  @override
  Future<bool> onNextPage(BuildContext context, WidgetRef ref) async => await Onboarding.login(context, ref, OnboardingFormKeys.credentials);

  @override
  String buttonText(BuildContext context) => context.l10n.login;

  @override
  String description(BuildContext context) => context.l10n.loginSubtitle;
}

class _UrlListTile extends ConsumerWidget {
  const _UrlListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? urlFieldValue = ref.read(onboardingTextFieldStateProvider(OnboardingTextFields.url)).value;

    final Map<String, String> urls = Map<String, String>.from(ref.read(remoteConfigValues)[RemoteConfig.canteenUrls]);
    final MapEntry<String, String> url = urls.entries.firstWhere(
      (e) => e.value == urlFieldValue,
      orElse: () => MapEntry('${Url.clean(urlFieldValue!).split('.').reversed.elementAt(1)}.cz', urlFieldValue),
    );

    return ListTile(title: Text(url.key), subtitle: Text(url.value));
  }
}
