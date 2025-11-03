import 'package:autojidelna/features/canteen/application/canteen.provider.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/features/canteen/presentation/page_view/page_view_food_card.dart';
import 'package:icanteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DishList extends ConsumerWidget {
  const DishList(this.date, {super.key});
  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CanteenProvider canteen = ref.read(canteenProvider);

    Jidelnicek? menu = canteen.getCachedMenu(date);
    if (menu == null) return const Center(child: CircularProgressIndicator());
    List<Jidlo> dishList = menu.nabidka;

    if (dishList.isEmpty) return emptyList(context);

    return RefreshIndicator(
      onRefresh: canteen.refreshCurrentPage,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 24),
        itemCount: dishList.length,
        itemBuilder: (context, index) => PageViewFoodCard(dishList[index]),
      ),
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
