import 'package:autojidelna/features/canteen/application/providers.dart';
import 'package:autojidelna/features/canteen/presentation/page_view/dish_list.dart';
import 'package:autojidelna/features/canteen/presentation/error_loading_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuOfTheDay extends ConsumerWidget {
  const MenuOfTheDay(this.date, {super.key});
  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(denniNabidkaProvider(date))
        .when(
          data: (menu) => DishList(date),
          error: (e, st) => const ErrorLoadingData(),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
