import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:autojidelna/shared/snackbars/show_internet_connection_snack_bar.dart';
import 'package:autojidelna/shared/widgets/divider_with_text.dart';
import 'package:autojidelna/features/onboarding/onboarding.dart';
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';
import 'package:autojidelna/features/onboarding/application/onboarding_providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _SelectedSafeAccountNotifier extends Notifier<SafeAccount> {
  @override
  SafeAccount build() => ref.read(userProvider).loggedInAccounts.first;

  @override
  set state(SafeAccount newState) => super.state = newState;
  SafeAccount update(SafeAccount Function(SafeAccount state) cb) => state = cb(state);
}

final _selectedSafeAccount = NotifierProvider<_SelectedSafeAccountNotifier, SafeAccount>(_SelectedSafeAccountNotifier.new);

class AccountPickerOnboarding extends ConsumerWidget implements OnboardingStep {
  const AccountPickerOnboarding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<SafeAccount> accounts = ref.read(userProvider).loggedInAccounts;

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
                  enabled: ref.watch(_selectedSafeAccount) == account || !ref.watch(disableInteractions),
                  trailing: ref.watch(_selectedSafeAccount) == account ? const Icon(Icons.check) : null,
                  onTap: ref.watch(disableInteractions) ? null : () => ref.read(_selectedSafeAccount.notifier).state = account,
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
              ref.read(onboardingStepsProvider.notifier).addLoginPages();
              Onboarding.nextPage();
            },
          ),
        ],
      ),
    );
  }

  @override
  Future<bool> onPreviousPage(BuildContext context, WidgetRef ref) async => true;

  @override
  Future<bool> onNextPage(BuildContext context, WidgetRef ref) async {
    final userProv = ref.read(userProvider);

    ref.read(disableInteractions.notifier).state = true;

    bool allowNextPage = true;
    try {
      await userProv.changeUser(ref.read(_selectedSafeAccount));
      await userProv.loadUser();
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
          if (await showInternetConnectionSnackBar() && context.mounted) return await onNextPage(context, ref);
          break;
        case AuthErrors.wrongCredentials:
          showErrorSnackBar(SnackBarAuthErrors.wrongCredentials(l10n));
          break;
        case AuthErrors.wrongUrl:
          showErrorSnackBar(SnackBarAuthErrors.wrongUrl(l10n));
          break;
        default:
      }
      allowNextPage = false;
    }
    ref.read(disableInteractions.notifier).state = false;
    return allowNextPage;
  }

  @override
  String buttonText(BuildContext context) => context.l10n.login;

  @override
  String description(BuildContext context) => context.l10n.loginSubtitle;
}
