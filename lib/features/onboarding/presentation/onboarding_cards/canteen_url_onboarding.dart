import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:autojidelna/shared/providers/text_fields/text_field_state.dart';
import 'package:autojidelna/shared/widgets/divider_with_text.dart';
import 'package:autojidelna/features/onboarding/onboarding.dart';
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';
import 'package:autojidelna/features/onboarding/application/onboarding_providers.dart';
import 'package:autojidelna/features/onboarding/presentation/onboarding_cards/account_picker_onboarding.dart';
import 'package:autojidelna/features/onboarding/presentation/widgets/canteen_url_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CanteenUrlOnboarding extends ConsumerWidget implements OnboardingStep {
  const CanteenUrlOnboarding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n l10n = context.l10n;
    final TextFieldState provider = ref.watch(onboardingTextFieldStateProvider(OnboardingTextFields.url));

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 5, 16, provider.error == null ? 0 : 5),
            child: Form(
              key: ref.read(onboardingFormKeyProvider(OnboardingFormKeys.url)),
              child: TextFormField(
                controller: ref.watch(onboardingTextFieldControllerProvider(OnboardingTextFields.url)),
                focusNode: ref.watch(onboardingFocusNodeProvider(OnboardingTextFields.url)),
                autocorrect: false,
                enabled: !ref.watch(disableInteractions),
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.url],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: l10n.loginUrlFieldLabel,
                  errorText: provider.error,
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: ref.read(onboardingTextFieldControllerProvider(OnboardingTextFields.url)),
                    builder: (_, urlController, ___) => urlController.text.isEmpty
                        ? const Icon(Icons.edit_rounded)
                        : IconButton(
                            onPressed: ref.read(onboardingTextFieldControllerProvider(OnboardingTextFields.url)).clear,
                            icon: const Icon(Icons.close),
                          ),
                  ),
                ),
                onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                validator: (value) => (value?.isEmpty ?? true) ? l10n.loginUrlFieldHint : null,
                onSaved: ref.read(onboardingTextFieldStateProvider(OnboardingTextFields.url).notifier).setValue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DividerWithText(text: l10n.or),
          ),
          ConstrainedBox(constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * .4), child: const CanteenUrlPicker()),
        ],
      ),
    );
  }

  @override
  Future<bool> onPreviousPage(BuildContext context, WidgetRef ref) async {
    ref.invalidate(onboardingFormKeyProvider(OnboardingFormKeys.url));
    ref.invalidate(onboardingTextFieldControllerProvider(OnboardingTextFields.url));
    ref.invalidate(onboardingTextFieldStateProvider(OnboardingTextFields.url));

    if (ref.read(onboardingPagesProvider).any((step) => step.runtimeType == AccountPickerOnboarding)) {
      // Delay so that the page is removed after the page changing animation is finished
      Future.delayed(Durations.medium1, ref.read(onboardingPagesProvider.notifier).removeLoginPages);
    }

    return true;
  }

  @override
  Future<bool> onNextPage(BuildContext context, WidgetRef ref) async => await Onboarding.login(context, ref, OnboardingFormKeys.url);

  @override
  String buttonText(BuildContext context) => context.l10n.next;

  @override
  String description(BuildContext context) => context.l10n.loginSubtitle;
}
