import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/types/freezed/safe_account/safe_account.dart';
import 'package:autojidelna/core/types/freezed/user/user.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:autojidelna/shared/widgets/configured_dialog.dart';
import 'package:autojidelna/shared/widgets/section_title.dart';
import 'package:autojidelna/features/auth/presentation/logout_dialog.dart';
import 'package:autojidelna/features/more/presentation/account_overview_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icanteenlib/canteenlib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n l10n = context.l10n;
    final User provUser = ref.read(userProvider).user!;
    final UzivatelskeUdaje user = provUser.data!;

    bool firstName = user.jmeno != null && user.jmeno!.trim().isNotEmpty;
    bool lastName = user.prijmeni != null && user.prijmeni!.trim().isNotEmpty;
    bool category = user.kategorie != null && user.kategorie!.trim().isNotEmpty;
    bool bankAccount = user.ucetProPlatbyDoJidelny != null && user.ucetProPlatbyDoJidelny!.trim().isNotEmpty;
    bool varSymbol = user.variabilniSymbol != null && user.variabilniSymbol!.trim().isNotEmpty;
    bool specSymbol = user.specifickySymbol != null && user.specifickySymbol!.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.account), actions: [_appBarLogoutButton(context, provUser.accountData)]),
      body: ListView(
        children: [
          const CustomDivider(height: 30),
          const AccountOverviewCard(),
          const CustomDivider(height: 38),
          if ((firstName && lastName) || category) SectionTitle(l10n.personalInfo),
          if (firstName && lastName) ListTile(title: Text('${user.jmeno!} ${user.prijmeni!}'), subtitle: Text(l10n.name)),
          if (category) ListTile(title: Text(user.kategorie!), subtitle: Text(l10n.category)),
          if (bankAccount || varSymbol || specSymbol) SectionTitle(l10n.paymentInfo),
          if (bankAccount)
            ListTile(
              title: Text(user.ucetProPlatbyDoJidelny!),
              subtitle: Text(l10n.paymentAccountNumber),
              onLongPress: () => _copyToClipboard(user.ucetProPlatbyDoJidelny!),
            ),
          if (varSymbol)
            ListTile(
              title: Text(user.variabilniSymbol!),
              subtitle: Text(l10n.variableSymbol),
              onLongPress: () => _copyToClipboard(user.variabilniSymbol!),
            ),
          if (specSymbol)
            ListTile(
              title: Text(user.specifickySymbol!),
              subtitle: Text(l10n.specificSymbol),
              onLongPress: () => _copyToClipboard(user.specifickySymbol!),
            ),
        ],
      ),
    );
  }

  Padding _appBarLogoutButton(BuildContext context, SafeAccount safeAccount) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        onPressed: () => configuredDialog(context, builder: (BuildContext context) => logoutDialog(safeAccount)),
        icon: const Icon(Icons.logout),
      ),
    );
  }

  void _copyToClipboard(String text) async {
    Clipboard.setData(ClipboardData(text: text));
  }
}
