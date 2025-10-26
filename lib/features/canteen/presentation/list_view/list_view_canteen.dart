import 'dart:async';

import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/features/canteen/application/selected_date.dart';
import 'package:autojidelna/shared/config/dates.dart';
import 'package:autojidelna/features/canteen/application/canteen.provider.dart';
import 'package:autojidelna/shared/utils/datetime_utils.dart';
import 'package:autojidelna/features/canteen/presentation/list_view/day_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_list_view/flutter_list_view.dart';

class ListViewCanteen extends ConsumerStatefulWidget {
  const ListViewCanteen({super.key});

  @override
  ConsumerState<ListViewCanteen> createState() => _ListViewCanteenState();
}

class _ListViewCanteenState extends ConsumerState<ListViewCanteen> {
  Timer? _debounceTimer;

  void _updateVisibleItem() {
    final visibleRange = App.listController.sliverController.getVisibleIndexData();
    if (visibleRange == null || visibleRange.isEmpty) return;

    final DateTime visibleDate = (visibleRange.first as int).toDateTime();

    _debounceTimer?.cancel();
    _debounceTimer = Timer(Durations.short1, () {
      final selectedDate = ref.read(selectedDateProvider);
      if (selectedDate != visibleDate) {
        ref.read(selectedDateProvider.notifier).state = visibleDate;
      }
    });
  }

  @override
  void dispose() {
    App.listController.removeListener(_updateVisibleItem);
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    App.listController.addListener(_updateVisibleItem);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ref.read(canteenProvider).refreshList,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: FlutterListView(
        controller: App.listController,
        scrollDirection: Axis.vertical,
        delegate: FlutterListViewDelegate(
          initIndex: DateTime.now().toIndex(),
          childCount: Dates.maximalDate.difference(Dates.minimalDate).inDays,
          (BuildContext context, int index) => DayCard(index.toDateTime()),
        ),
      ),
    );
  }
}
