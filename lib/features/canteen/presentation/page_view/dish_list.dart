import 'package:autojidelna/features/canteen/presentation/error_loading_data.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/features/canteen/application/providers.dart';
import 'package:autojidelna/features/canteen/presentation/page_view/page_view_food_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icanteenlib/canteenlib.dart';

class DishList extends ConsumerWidget {
  const DishList(this.date, {super.key});
  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuAsync = ref.watch(denniNabidkaProvider(date));

    return menuAsync.when(
      data: (menu) {
        List<Jidlo> dishList = menu.nabidka;

        if (dishList.isEmpty) return emptyList(context);

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 24),
          itemCount: dishList.length,
          itemBuilder: (context, index) => PageViewFoodCard(dishList[index]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const ErrorLoadingData(),
    );
  }

  Widget emptyList(BuildContext context) => SingleChildScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    child: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height / 2 - 100),
        child: Text(context.l10n.noFood),
      ),
    ),
  );
}
