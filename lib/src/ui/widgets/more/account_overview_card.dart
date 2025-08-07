import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/widgets/configured_bottom_sheet.dart';
import 'package:autojidelna/shared/widgets/lined_card.dart';
import 'package:autojidelna/src/ui/widgets/switch_account_panel.dart';
import 'package:canteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountOverviewCard extends ConsumerWidget {
  const AccountOverviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n lang = context.l10n;
    Uzivatel? user = ref.watch(userProvider.select((it) => it.user?.data));

    return LinedCard(
      title: user?.uzivatelskeJmeno ?? '',
      footer: lang.changeAccount,
      onPressed: () => configuredBottomSheet(context, builder: (context) => const SwitchAccountPanel()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.account_circle, size: 75),
          const VerticalDivider(color: Colors.transparent),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(lang.credit(user?.kredit ?? 0), style: Theme.of(context).textTheme.titleMedium),
              if (user != null && user.kategorie != null) Text(user.kategorie!),
            ],
          ),
        ],
      ),
    );
  }
}
