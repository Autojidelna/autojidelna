import 'package:autojidelna/shared/settings/providers/settings_notifiers.dart';
import 'package:autojidelna/features/canteen/application/canteen.provider.dart';
import 'package:autojidelna/shared/utils/get_correct_date_string.dart';
import 'package:autojidelna/core/utils/string_extension.dart';
import 'package:autojidelna/src/ui/widgets/canteen/list_view/food_section_list_tile.dart';
import 'package:autojidelna/src/ui/widgets/custom_divider.dart';
import 'package:autojidelna/src/ui/widgets/snackbars/show_internet_connection_snack_bar.dart';
import 'package:canteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DayCard extends ConsumerWidget {
  const DayCard(this.date, {super.key});
  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Jidelnicek? menu = ref.watch(canteenProvider).getCachedMenu(date);

    Map<String, List<Jidlo>> sortedDishes = {};
    if (menu == null) {
      try {
        // ignore: discarded_futures
        ref.read(canteenProvider).getMenu(date);
      } catch (e) {
        // ignore: discarded_futures
        showInternetConnectionSnackBar();
      }
    } else {
      sortedDishes = mapDishesByVarianta(menu.jidla);
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          DayCardheader(date: date),
          if (menu != null && menu.jidla.isNotEmpty) ...[const CustomDivider(isTransparent: false, height: 0), const SizedBox(height: 8)],
          ...sortedDishes.entries.map((e) => FoodSectionListTile(title: e.key.toUpperCase(), selection: e.value)),
        ],
      ),
    );
  }
}

// Using regular expression to remove digits and extra spaces ['OBĚD 1' => 'OBĚD']
String normalizeVarianta(String varianta) => varianta.replaceAll(RegExp(r'\d'), '').trim();

// Group dishes by normalized `varianta`
Map<String, List<Jidlo>> mapDishesByVarianta(List<Jidlo> dishes) {
  Map<String, List<Jidlo>> mappedDishes = {};

  for (Jidlo dish in dishes) {
    String normalizedVarianta = normalizeVarianta(dish.varianta);

    if (mappedDishes.containsKey(normalizedVarianta)) {
      mappedDishes[normalizedVarianta]!.add(dish);
    } else {
      mappedDishes[normalizedVarianta] = [dish];
    }
  }

  return mappedDishes;
}

class DayCardheader extends ConsumerWidget {
  const DayCardheader({required this.date, super.key});
  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String day = DateFormat('EEEE', Localizations.localeOf(context).toLanguageTag()).format(date).capitalize();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        '$day - ${getCorrectDateString(ref.watch(dateFormatOptionProvider), date: date)}',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
