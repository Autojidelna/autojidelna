import 'dart:async';

import 'package:autojidelna/app/routing/app_router.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/features/canteen/application/selected_date.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:autojidelna/shared/utils/datetime_utils.dart';
import 'package:autojidelna/shared/snackbars/show_internet_connection_snack_bar.dart';
import 'package:autojidelna/features/canteen/data/canteen_service.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:icanteenlib/canteenlib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final canteenProvider = ChangeNotifierProvider<CanteenProvider>((ref) => CanteenProvider(ref, CanteenService(ref)));

class CanteenProvider with ChangeNotifier {
  CanteenProvider(this._ref, this._canteenService);

  final CanteenService _canteenService;
  final Ref _ref;

  /// Store menus by day index
  Map<DateTime, Jidelnicek> _menus = {};

  List<Burza> _dishMarketplace = [];

  Future<void> getMenu(DateTime date) async {
    try {
      final futures = <Future>[];

      if (date.normalize.isBefore(DateTime.now().normalize)) {
        futures.add(_getMonthlyMenu());
      } else {
        futures.add(_getDailyMenu(date));
      }

      await Future.wait(futures);
    } catch (e) {
      await handleErrors(e);
    } finally {
      notifyListeners();
    }
  }

  Future<bool> _getDailyMenu(DateTime date) async {
    Jidelnicek? menu = await _canteenService.getDailyMenu(date.normalize);
    if (menu == null) return false;
    setMenu(menu);
    return true;
  }

  Future<bool> _getMonthlyMenu() async {
    List<Jidelnicek>? menuList = await _canteenService.getMonthlyMenu();
    if (menuList == null || menuList.isEmpty) return false;
    for (Jidelnicek m in menuList) {
      setMenu(m);
    }
    return true;
  }

  Jidelnicek? getCachedMenu(DateTime selectedDate) => _menus[selectedDate.normalize];

  Future<void> preIndexMenus({DateTime? targetDate}) async {
    try {
      targetDate ??= _ref.read(selectedDateProvider) ?? DateTime.now().normalize;

      // If monthly menu fetching is available, use it
      if (targetDate.normalize.isBefore(DateTime.now().normalize)) {
        await _getMonthlyMenu();
        notifyListeners();
        return;
      }

      // Otherwise, use smart pre-indexing around the target date
      await _smartPreIndexing(targetDate);
    } catch (e) {
      await handleErrors(e);
    }
  }

  Future<void> _smartPreIndexing(DateTime targetDate) async {
    try {
      await Future.wait([
        _preIndexLunchesRange(targetDate, 3),
        _preIndexLunchesRange(targetDate.subtract(const Duration(days: 2)), 2),
        _preIndexLunchesRange(targetDate.add(const Duration(days: 3)), 3),
        _preIndexLunchesRange(targetDate.add(const Duration(days: 6)), 3),
        _preIndexLunchesRange(targetDate.add(const Duration(days: 9)), 3),
        _preIndexLunchesRange(targetDate.subtract(const Duration(days: 5)), 3),
        _preIndexLunchesRange(targetDate.add(const Duration(days: 12)), 3),
        _preIndexLunchesRange(targetDate.add(const Duration(days: 15)), 3),
        _preIndexLunchesRange(targetDate.add(const Duration(days: 18)), 3),
        _preIndexLunchesRange(targetDate.add(const Duration(days: 21)), 3),
        _preIndexLunchesRange(targetDate.subtract(const Duration(days: 8)), 3),
      ]);
    } catch (_) {}
  }

  Future<void> _preIndexLunchesRange(DateTime start, int howManyDays) async {
    for (int i = 0; i < howManyDays; i++) {
      DateTime date = start.add(Duration(days: i)).normalize;
      if (!_menus.containsKey(date)) {
        Jidelnicek? menu = await _canteenService.getDailyMenu(date);
        if (menu != null) {
          _menus[date] = menu;
          notifyListeners();
        }
      }
    }
  }

  void updateMenu(Jidelnicek menu) {
    setMenu(menu, notify: false);
  }

  void setMenu(Jidelnicek menu, {bool notify = true}) {
    DateTime tempDate = menu.datum.normalize;
    if (_menus[tempDate] == menu) return;
    _menus.update(tempDate, (_) => menu, ifAbsent: () => menu);
    _menus = Map.from(_menus);
    if (notify) notifyListeners();
  }

  void changeLocation(int id) {
    _canteenService.changeLocation(id);
    _menus = Map.from({});
    notifyListeners();
  }

  /// Checks if a dish is on the market
  bool dishOnMarketplace(Jidlo dish) {
    for (Burza jidloNaBurze in _dishMarketplace) {
      if (jidloNaBurze.datum == dish.datum && jidloNaBurze.varianta == dish.varianta) return true;
    }

    return false;
  }

  /// Gets correct [Burza] dish for given [Jidlo] dish.
  /// Should be called after [dishOnMarketplace].
  Burza? getMarketplaceTypeDish(Jidlo dish) {
    for (Burza marketplaceDish in _dishMarketplace) {
      if (marketplaceDish.datum == dish.datum && marketplaceDish.varianta == dish.varianta) return marketplaceDish;
    }
    return null;
  }

  Future<void> refreshCurrentPage() async => getMenu(_ref.read(selectedDateProvider));

  Future<void> refreshList() async {
    List<DateTime> closest = [_ref.read(selectedDateProvider)]; // Add the middle date first

    // Generate the 5 closest dates before and after the middle date
    for (int i = 1; i <= 5; i++) {
      closest.add(closest[0].add(Duration(days: i))); // Dates after
      if (i < 2) closest.add(closest[0].subtract(Duration(days: i))); // Dates before
    }

    for (DateTime date in closest) {
      await getMenu(date);
    }
  }

  Future<void> handleErrors(dynamic e) async {
    switch (e) {
      case CanteenErrors.needToLogin:
        try {
          await _ref.read(userProvider).loadUser();
        } catch (e) {
          await _ref.read(userProvider).unloadUser();
          _ref.read(appRouterProvider).replaceAll([const RouterRoute()], updateExistingRoutes: false);
        }
        break;
      case CanteenErrors.noInternetConnection:
        _ref.read(disableInteractions.notifier).state = true;
        await showInternetConnectionSnackBar();
        _ref.read(disableInteractions.notifier).state = false;
      default:
    }
  }

  void clear() {
    _menus = Map.from({});
    _dishMarketplace = List.from([]);
    notifyListeners();
  }
}
