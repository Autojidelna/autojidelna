import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/providers/text_fields/text_field_state.dart';
import 'package:autojidelna/shared/widgets/divider_with_text.dart';
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';
import 'package:autojidelna/features/onboarding/application/onboarding_providers.dart';
import 'package:autojidelna/features/onboarding/application/onboarding.dart';
import 'package:autojidelna/features/onboarding/presentation/widgets/canteen_url_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CanteenUrlOnboarding extends ConsumerWidget implements OnboardingStep {
  const CanteenUrlOnboarding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n l10n = context.l10n;
    final TextFieldState provider = ref.watch(textFieldProvider(OnboardingFields.url));

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 5, 16, provider.error == null ? 0 : 5),
            child: Form(
              key: ref.read(formKeyProvider(FormKeys.url)),
              child: TextFormField(
                controller: ref.watch(textFieldControllerProvider(OnboardingFields.url)),
                focusNode: ref.watch(focusNodeProvider(OnboardingFields.url)),
                autocorrect: false,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.url],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: l10n.loginUrlFieldLabel,
                  errorText: provider.error,
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: ref.read(textFieldControllerProvider(OnboardingFields.url)),
                    builder: (_, urlController, ___) => urlController.text.isEmpty
                        ? const Icon(Icons.edit_rounded)
                        : IconButton(onPressed: ref.read(textFieldControllerProvider(OnboardingFields.url)).clear, icon: const Icon(Icons.close)),
                  ),
                ),
                onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                validator: (value) => (value?.isEmpty ?? true) ? l10n.loginUrlFieldHint : null,
                onSaved: ref.read(textFieldProvider(OnboardingFields.url).notifier).setValue,
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
    ref.invalidate(formKeyProvider(FormKeys.url));
    ref.invalidate(textFieldControllerProvider(OnboardingFields.url));
    ref.invalidate(textFieldProvider(OnboardingFields.url));
    return true;
  }

  @override
  Future<bool> onNextPage(BuildContext context, WidgetRef ref) async => await Onboarding.login(context, ref, FormKeys.url);

  @override
  String buttonText(BuildContext context) => context.l10n.next;

  @override
  String description(BuildContext context) => context.l10n.loginSubtitle;
}
