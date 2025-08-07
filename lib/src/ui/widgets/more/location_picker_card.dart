import 'package:autojidelna/shared/theme/app_themes.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/src/_global/providers/canteen.provider.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/types/freezed/user/user.dart';
import 'package:autojidelna/src/ui/widgets/dialogs/configured_alert_dialog.dart';
import 'package:autojidelna/src/ui/widgets/dialogs/configured_dialog.dart';
import 'package:autojidelna/src/ui/widgets/lined_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

// TODO: Needs to be tested
class LocationPickerCard extends ConsumerStatefulWidget {
  const LocationPickerCard({super.key});

  @override
  ConsumerState<LocationPickerCard> createState() => _LocationPickerCardState();
}

class _LocationPickerCardState extends ConsumerState<LocationPickerCard> {
  @override
  Widget build(BuildContext context) {
    final L10n lang = context.l10n;
    User? user = ref.watch(userProvider.select((it) => (it.user)));
    final Map<int, String> locations = user?.canteenLocations ?? {};
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        LinedCard(
          title: lang.location,
          footer: locations.length > 1 ? lang.pickLocation : null,
          footerTextAlign: TextAlign.end,
          onPressed: locations.length < 2 ? null : () => pickerDialog(ref, locations),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(vertical: -4),
            title: Text(locations[ref.read(canteenProvider).locationId + 1] ?? locations[1] ?? lang.locationsUnknown),
          ),
        ),
        if (locations.isEmpty) lockedCover(context),
      ],
    );
  }

  void pickerDialog(WidgetRef ref, Map<int, String> locations) {
    final CanteenProvider provider = ref.read(canteenProvider);
    configuredDialog(
      context,
      builder: (context) => ConfiguredAlertDialog(
        title: context.l10n.pickLocation,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            locations.length,
            (i) => ListTile(
              visualDensity: VisualDensity.compact,
              title: Text(
                locations[i + 1]!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: provider.locationId == i ? const Icon(Icons.check) : null,
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
