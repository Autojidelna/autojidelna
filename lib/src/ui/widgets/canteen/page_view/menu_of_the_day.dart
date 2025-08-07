import 'dart:async';

import 'package:autojidelna/src/_global/providers/canteen.provider.dart';
import 'package:autojidelna/src/ui/widgets/canteen/page_view/dish_list.dart';
import 'package:autojidelna/src/ui/widgets/canteen/error_loading_data.dart';
import 'package:canteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuOfTheDay extends ConsumerStatefulWidget {
  const MenuOfTheDay(this.date, {super.key});
  final DateTime date;

  @override
  ConsumerState<MenuOfTheDay> createState() => _MenuOfTheDayState();
}

class _MenuOfTheDayState extends ConsumerState<MenuOfTheDay> {
  Future<void>? fetchMenu;

  @override
  void initState() {
    super.initState();
    fetchMenu = Future(() async {
      if (!mounted) return;
      CanteenProvider canteen = ref.read(canteenProvider);
      Jidelnicek? cachedMenu = canteen.getCachedMenu(widget.date);
      if (cachedMenu == null) await canteen.getMenu(widget.date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: fetchMenu,
      builder: (context, snapshot) {
        if (snapshot.hasError) return const ErrorLoadingData();
        if (snapshot.connectionState == ConnectionState.done) return DishList(widget.date);

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
