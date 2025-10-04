import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/core/crashlytics/crashlytics_service.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/providers/saved_accounts.dart';
import 'package:autojidelna/shared/widgets/configured_bottom_sheet.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:autojidelna/shared/widgets/configured_dialog.dart';
import 'package:autojidelna/shared/widgets/section_title.dart';
import 'package:autojidelna/features/auth/presentation/logout_dialog.dart';
import 'package:autojidelna/features/onboarding/onboarding.dart';
import 'package:autojidelna/features/onboarding/application/onboarding_providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([onboardingFormKey, OnboardingTextFieldState, OnboardingSteps, OnboardingFocusNodeFocus])
class SwitchAccountPanel extends StatelessWidget {
  const SwitchAccountPanel({super.key});

  static void open(BuildContext context) {
    configuredBottomSheet(context, builder: (context) => const SwitchAccountPanel());
  }

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;

    return Column(
      children: [
        SectionTitle(l10n.accounts),
        Consumer(
          builder: (context, ref, ___) {
            return ref.watch(savedAccountsProvider).when(
                  data: (savedAccounts) {
                    List<Widget> accounts = [for (SafeAccount account in savedAccounts) (accountRow(account))];

                    return Flexible(
                      child: ListView.builder(
                        itemCount: accounts.length,
                        itemBuilder: (_, index) => accounts[index],
                      ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) {
                    CrashlyticsService.error(e, st);
                    return Center(child: Text('Error: $e'));
                  },
                );
          },
        ),
        const CustomDivider(height: 0, isTransparent: false),
        addAccountButton(),
      ],
    );
  }

  Widget addAccountButton() {
    return Consumer(
      builder: (context, ref, child) {
        final L10n l10n = context.l10n;
        return ListTile(
          leading: child,
          title: Text(l10n.addAccount),
          onTap: () async {
            context.router.navigate(OnboardingRoute(steps: Onboarding.loginSteps));
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }

  Widget accountRow(SafeAccount safeAccount) {
    return Consumer(
      builder: (context, ref, child) {
        UserProvider prov = ref.read(userProvider);
        bool currentAccount = safeAccount == prov.user!.accountData;
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(safeAccount.username, style: currentAccount ? Theme.of(context).textTheme.titleMedium : null),
              if (currentAccount) const Icon(Icons.check, size: 30),
            ],
          ),
          trailing: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.logout, size: 30, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () async {
              if (!context.mounted) return;
              if (!currentAccount) {
                prov.logout(safeAccount);
              } else {
                configuredDialog(
                  context,
                  builder: (BuildContext context) => logoutDialog(safeAccount),
                );
              }
            },
          ),
          onTap: () async {
            if (currentAccount) return;
            await prov.changeUser(safeAccount);
            if (context.mounted) context.router.replaceAll([const RouterRoute()], updateExistingRoutes: false);
          },
        );
      },
    );
  }
}
