import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/features/onboarding/application/step_flow_controller.dart';
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/features/auth/data/login.provider.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/shared/snackbars/show_internet_connection_snack_bar.dart';
import 'package:autojidelna/shared/widgets/divider_with_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountPickerOnboarding extends ConsumerWidget implements OnboardingStep {
  const AccountPickerOnboarding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<SafeAccount> accounts = ref.read(userProvider).loggedInAccounts;
    final loginProv = ref.read(loginProvider);

    if (accounts.isNotEmpty && loginProv.pickedAccount == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => loginProv.setPickedAccount(accounts.first));
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * .4),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                SafeAccount account = accounts[index];

                return ListTile(
                  title: Text(account.username),
                  subtitle: Text(account.url),
                  enabled: ref.watch(loginProvider).pickedAccount == account || !ref.watch(disableInteractions),
                  trailing: ref.watch(loginProvider).pickedAccount == account ? const Icon(Icons.check) : null,
                  onTap: ref.watch(disableInteractions) ? null : () => loginProv.setPickedAccount(account),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DividerWithText(text: context.l10n.or),
          ),
          ListTile(
            enabled: !ref.watch(disableInteractions),
            leading: const Icon(Icons.add),
            title: Text(context.l10n.addAccount),
            onTap: () async {
              StepFlowController.instance.setLoginFlow();
              context.router.replaceAll([OnboardingRoute()]);
            },
          ),
        ],
      ),
    );
  }

  @override
  Future<bool> onNextPage(BuildContext context, {WidgetRef? ref}) async {
    final loginProv = ref!.read(loginProvider);
    final userProv = ref.read(userProvider);

    if (loginProv.pickedAccount == null) return false;
    ref.read(disableInteractions.notifier).state = true;

    try {
      await userProv.changeUser(loginProv.pickedAccount!);
      if (context.mounted) await userProv.loadUser();
    } catch (e) {
      if (!context.mounted) return false;
      final L10n l10n = context.l10n;
      switch (e) {
        case AuthErrors.accountNotSelected:
          showErrorSnackBar(SnackBarAuthErrors.accountNotFound(l10n));
          break;
        case AuthErrors.connectionFailed:
          showErrorSnackBar(SnackBarAuthErrors.connectionFailed(l10n));
          break;
        case AuthErrors.noInternetConnection:
          if (await showInternetConnectionSnackBar() && context.mounted) return await onNextPage(context);
          break;
        case AuthErrors.wrongCredentials:
          showErrorSnackBar(SnackBarAuthErrors.wrongCredentials(l10n));
          break;
        case AuthErrors.wrongUrl:
          showErrorSnackBar(SnackBarAuthErrors.wrongUrl(l10n));
          break;
        default:
      }
      if (context.mounted) ref.read(disableInteractions.notifier).state = false;
      return false;
    }
    if (context.mounted) ref.read(disableInteractions.notifier).state = false;

    return true;
  }

  @override
  String buttonText(BuildContext context) => context.l10n.login;

  @override
  String description(BuildContext context) => context.l10n.loginSubtitle;
}
