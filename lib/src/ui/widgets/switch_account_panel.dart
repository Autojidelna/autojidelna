import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/features/onboarding/application/step_flow_controller.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:autojidelna/shared/widgets/configured_dialog.dart';
import 'package:autojidelna/src/ui/widgets/dialogs/logout_dialog.dart';
import 'package:autojidelna/shared/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchAccountPanel extends StatelessWidget {
  const SwitchAccountPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final L10n lang = context.l10n;

    return Column(
      children: [
        SectionTitle(lang.accounts),
        Consumer(
          builder: (context, ref, ___) {
            final UserProvider user = ref.watch(userProvider);
            if (user.user == null) return const Flexible(child: SizedBox());

            List<Widget> accounts = [];

            for (int i = 0; i < user.loggedInAccounts.length; i++) {
              accounts.add(accountRow(context, ref, user.loggedInAccounts[i]));
            }

            return Flexible(
              child: ListView.builder(
                itemCount: accounts.length,
                itemBuilder: (_, index) => accounts[index],
              ),
            );
          },
        ),
        const CustomDivider(height: 0, isTransparent: false),
        addAccountButton(context),
      ],
    );
  }

  Widget addAccountButton(BuildContext context) {
    final L10n lang = context.l10n;
    return ListTile(
      leading: const Icon(Icons.add),
      title: Text(lang.addAccount),
      onTap: () async {
        StepFlowController.instance.setLoginFlow();
        context.router.navigate(OnboardingRoute());
      },
    );
  }

  Widget accountRow(BuildContext context, WidgetRef ref, SafeAccount safeAccount) {
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
              builder: (BuildContext context) => logoutDialog(context, safeAccount),
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
  }
}
