import 'dart:async';

import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/types/freezed/user/user.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';
import 'package:autojidelna/shared/theme/app_themes.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/widgets/configured_alert_dialog.dart';
import 'package:autojidelna/shared/widgets/configured_dialog.dart';
import 'package:autojidelna/shared/widgets/lined_card.dart';
import 'package:autojidelna/features/canteen/application/canteen.provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:icanteenlib/canteenlib.dart';

class LocationPickerCard extends ConsumerStatefulWidget {
  const LocationPickerCard({super.key});

  @override
  ConsumerState<LocationPickerCard> createState() => _LocationPickerCardState();
}

class _LocationPickerCardState extends ConsumerState<LocationPickerCard> {
  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;
    return StreamBuilder(
      initialData: ref.watch(currentCanteen)!.stavUctu,
      stream: ref.watch(currentCanteen)!.stavUctuStream,
      builder: (context, asyncSnapshot) {
        print(asyncSnapshot.data);
        if (!asyncSnapshot.hasData) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              LinedCard(
                title: l10n.location,
                footerTextAlign: TextAlign.end,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(vertical: -4),
                  title: Text(l10n.locationsUnknown),
                ),
              ),
              lockedCover(context),
            ],
          );
        }
        final Map<int, String> locations = asyncSnapshot.data?.vydejny ?? {};
        (int, String)? vydejna = asyncSnapshot.data?.vydejna;
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            LinedCard(
              title: l10n.location,
              footer: locations.isNotEmpty ? l10n.pickLocation : null,
              footerTextAlign: TextAlign.end,
              onPressed: locations.isEmpty ? null : () => pickerDialog(ref, asyncSnapshot.data),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                visualDensity: const VisualDensity(vertical: -4),
                title: Text(vydejna?.$2 ?? l10n.locationsUnknown),
              ),
            ),
            if (vydejna == null) lockedCover(context),
          ],
        );
      },
    );
  }

  void pickerDialog(WidgetRef ref, StavUctu? stavUctu) {
    if (stavUctu == null) {
      unawaited(ref.read(currentCanteen)?.aktualizujStavUctu());
      return;
    }
    final CanteenProvider provider = ref.read(canteenProvider);
    configuredDialog(
      context,
      builder: (context) => ConfiguredAlertDialog(
        title: context.l10n.pickLocation,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            stavUctu.vydejny.length,
            (i) => ListTile(
              visualDensity: VisualDensity.compact,
              title: Text(stavUctu.vydejny[i + 1] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: stavUctu.vydejna!.$1 == i + 1 ? const Icon(Icons.check) : null,
              onTap: () async {
                provider.changeLocation(i);
                provider.preIndexMenus();

                Navigator.of(context).popUntil((route) => route.isFirst);
                User user = ref.read(userProvider).user!;
                Hive.box(Boxes.appState).put(HiveKeys.account.location(user.accountData), i);
              },
            ),
          ),
        ),
      ),
    );
  }

  Positioned lockedCover(BuildContext context) {
    return Positioned.fill(
      child: Container(
        margin: AppThemes.horizontalMargin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.onInverseSurface.withValues(alpha: .9),
          border: Border.all(color: Theme.of(context).dividerTheme.color!),
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.lock_outline_rounded),
      ),
    );
  }
}
