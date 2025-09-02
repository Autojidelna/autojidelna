import 'package:autojidelna/features/onboarding/application/onboarding_providers.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/providers/text_fields/text_field_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomUrlField extends ConsumerWidget {
  const CustomUrlField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final TextFieldState provider = ref.watch(textFieldProvider(OnboardingFields.url));

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 5, 16, provider.error == null ? 0 : 5),
      child: Form(
        key: ref.read(formKeyProvider(FormKeys.url)),
        child: TextFormField(
          controller: ref.watch(textFieldControllerProvider(OnboardingFields.url)),
          autocorrect: false,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.url],
          decoration: InputDecoration(
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: l10n.loginUrlFieldLabel,
            errorStyle: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.error, height: .04),
            errorText: provider.error,
            suffixIcon: const Icon(Icons.edit_rounded),
          ),
          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          validator: (value) => value == null || value.isEmpty ? l10n.loginUrlFieldHint : null,
          onSaved: ref.read(textFieldProvider(OnboardingFields.url).notifier).setValue,
        ),
      ),
    );
  }
}
