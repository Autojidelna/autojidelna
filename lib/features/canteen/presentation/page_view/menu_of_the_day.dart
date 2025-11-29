import 'package:autojidelna/features/canteen/presentation/page_view/dish_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuOfTheDay extends ConsumerWidget {
  const MenuOfTheDay(this.date, {super.key});
  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DishList(date);
  }
}
