import 'package:autojidelna/core/crashlytics/crashlytics_service.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:autojidelna/shared/providers/saved_accounts.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:autojidelna/shared/snackbars/show_internet_connection_snack_bar.dart';
import 'package:autojidelna/shared/widgets/divider_with_text.dart';
import 'package:autojidelna/features/onboarding/onboarding.dart';
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

class _SelectedSafeAccountNotifier extends Notifier<SafeAccount?> {
  @override
  SafeAccount? build() => null;

  @override
  set state(SafeAccount? newState) => super.state = newState;
  SafeAccount? update(SafeAccount? Function(SafeAccount? state) cb) => state = cb(state);
}

final _selectedSafeAccount = NotifierProvider<_SelectedSafeAccountNotifier, SafeAccount?>(_SelectedSafeAccountNotifier.new);

@Dependencies([onboardingFormKey, OnboardingSteps, OnboardingTextFieldState, OnboardingFocusNodeFocus])
class AccountPickerOnboarding extends ConsumerWidget implements OnboardingStep {
  const AccountPickerOnboarding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedAccounts = ref.watch(savedAccountsProvider);

    return savedAccounts.when(
      data: (accounts) {
        List<Widget> widgets = [for (final account in accounts) accountRow(account)];

        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (ref.read(_selectedSafeAccount) == null) ref.read(_selectedSafeAccount.notifier).state = accounts.first;
        });

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * .4),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widgets.length,
                  itemBuilder: (context, index) => widgets[index],
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
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) {
        CrashlyticsService.error(e, st);
        return Center(child: Text('Error: $e'));
      },
    );
  }

  Widget accountRow(SafeAccount account) => Consumer(
        builder: (_, ref, ___) {
          return ListTile(
            title: Text(account.username),
            subtitle: Text(account.url),
            enabled: ref.watch(_selectedSafeAccount) == account || !ref.watch(disableInteractions),
            trailing: ref.watch(_selectedSafeAccount) == account ? const Icon(Icons.check) : null,
            onTap: ref.watch(disableInteractions) ? null : () => ref.read(_selectedSafeAccount.notifier).state = account,
          );
        },
      );

  @override
  Future<bool> onPreviousPage(BuildContext context, WidgetRef ref) async => true;

  @override
  Future<bool> onNextPage(BuildContext context, WidgetRef ref) async {
    if (ref.read(_selectedSafeAccount) == null) return false;
    final userProv = ref.read(currentCanteenProvider.notifier);

    ref.read(disableInteractions.notifier).state = true;

    bool allowNextPage = true;
    try {
      await userProv.changeAccount(ref.read(_selectedSafeAccount)!);
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
