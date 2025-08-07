import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/shared/config/dates.dart';
import 'package:autojidelna/features/canteen/application/canteen.provider.dart';
import 'package:autojidelna/shared/utils/datetime_utils.dart';
import 'package:autojidelna/src/ui/widgets/canteen/page_view/menu_of_the_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageViewCanteen extends ConsumerStatefulWidget {
  const PageViewCanteen({super.key});

  @override
  ConsumerState<PageViewCanteen> createState() => _PageViewCanteenState();
}

class _PageViewCanteenState extends ConsumerState<PageViewCanteen> {
  @override
  void initState() {
    super.initState();
    App.pageController = PageController(
      keepPage: true,
      initialPage: DateTime.now().toIndex(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CanteenProvider canteen = ref.read(canteenProvider);
    return RefreshIndicator(
      onRefresh: canteen.refreshCurrentPage,
      child: PageView.builder(
        controller: App.pageController,
        scrollDirection: Axis.horizontal,
        itemCount: Dates.maximalDate.difference(Dates.minimalDate).inDays,
        onPageChanged: canteen.setDayIndex,
        itemBuilder: (_, index) => MenuOfTheDay(index.toDateTime()),
      ),
    );
  }
}
