import 'package:autojidelna/features/auth/data/login.provider.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomUrlField extends ConsumerWidget {
  const CustomUrlField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n l10n = context.l10n;
    final LoginProvider provider = ref.watch(loginProvider);
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 5, 16, provider.urlError == null ? 0 : 5),
      child: Form(
        key: provider.urlForm,
        child: TextFormField(
          controller: provider.urlController,
          autocorrect: false,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.url],
          decoration: InputDecoration(
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: l10n.loginUrlFieldLabel,
            errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: theme.colorScheme.error, height: .04),
            errorText: provider.urlError,
            suffixIcon: const Icon(Icons.edit_rounded),
          ),
          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          validator: (value) => value == null || value.isEmpty ? l10n.loginUrlFieldHint : null,
        ),
      ),
    );
  }
}
