import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';
import 'package:autojidelna/src/_conf/errors.dart';
import 'package:autojidelna/src/_global/providers/account.provider.dart';
import 'package:autojidelna/src/_global/providers/login.provider.dart';
import 'package:autojidelna/src/lang/l10n_context_extension.dart';
import 'package:autojidelna/src/logic/show_snack_bar.dart';
import 'package:autojidelna/src/types/errors.dart';
import 'package:autojidelna/src/types/freezed/account/account.dart';
import 'package:autojidelna/src/ui/widgets/divider_with_text.dart';
import 'package:autojidelna/src/ui/widgets/login/canteen_url_picker.dart';
import 'package:autojidelna/src/ui/widgets/login/custom_url_field.dart';
import 'package:autojidelna/src/ui/widgets/snackbars/show_internet_connection_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CanteenUrlOnboarding extends StatelessWidget implements OnboardingStep {
  const CanteenUrlOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const CustomUrlField(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DividerWithText(text: context.l10n.or),
          ),
          ConstrainedBox(constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * .4), child: const CanteenUrlPicker()),
        ],
      ),
    );
  }

  @override
  Future<bool> onNextPage(BuildContext context, {WidgetRef? ref}) async {
    final loginProv = ref!.read(loginProvider);

    if (!loginProv.urlForm.currentState!.validate()) {
      loginProv.loggingIn = false;
      return false;
    }
    loginProv.setErrors(null, false, null);
    loginProv.loggingIn = true;
    bool value = true;
    try {
      await ref.read(userProvider).login(Account(username: '', password: '', url: loginProv.urlController.text));
    } catch (e) {
      switch (e) {
        case AuthErrors.wrongUrl:
          if (context.mounted) {
            loginProv.setErrors(null, false, context.l10n.errorsWrongUrl);
            value = false;
          }
          break;
        case AuthErrors.noInternetConnection:
          if (await showInternetConnectionSnackBar() && context.mounted) onNextPage(context);
          break;
        case AuthErrors.connectionFailed:
          if (context.mounted) showErrorSnackBar(SnackBarAuthErrors.connectionFailed(context.l10n));
          value = false;
          break;
        default:
      }
    }
    if (context.mounted) {
      loginProv.loggingIn = false;
      loginProv.usernameController.clear();
      loginProv.passwordController.clear();
    }

    return value;
  }

  @override
  String buttonText(BuildContext context) => context.l10n.next;

  @override
  String description(BuildContext context) => context.l10n.loginSubtitle;
}
