import 'package:autojidelna/core/types/freezed/user.dart';
import 'package:autojidelna/features/auth/presentation/switch_account_panel.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';
import 'package:autojidelna/shared/widgets/lined_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountOverviewCard extends ConsumerWidget {
  const AccountOverviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final L10n l10n = context.l10n;
    User? user = ref.watch(userProvider).user;

    return LinedCard(
      title: user?.accountData.username ?? '',
      footer: l10n.changeAccount,
      onPressed: () => SwitchAccountPanel.open(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.account_circle, size: 75),
          const VerticalDivider(color: Colors.transparent),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Builder(
                builder: (context) {
                  final canteen = ref.watch(currentCanteen);
                  if (canteen == null) return Text(l10n.credit(0), style: Theme.of(context).textTheme.titleMedium);

                  return StreamBuilder(
                    initialData: canteen.stavUctu,
                    stream: canteen.stavUctuStream,
                    builder: (context, asyncSnapshot) {
                      return Text(l10n.credit(asyncSnapshot.data?.kredit ?? 0), style: Theme.of(context).textTheme.titleMedium);
                    },
                  );
                },
              ),

              if (user != null && user.data?.kategorie != null) Text(user.data!.kategorie!),
            ],
          ),
        ],
      ),
    );
  }
}
