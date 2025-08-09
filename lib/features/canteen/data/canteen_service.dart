import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';
import 'package:autojidelna/shared/utils/datetime_utils.dart';

import 'package:canteenlib/canteenlib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CanteenService {
  CanteenService(this._ref);
  final Ref _ref;

  /// Sets how many max lunches are expected. The higher the worse performance but less missing lunches. This is a fix for the api sometimes not sending all the lunches
  static const int numberOfLunches = 3;
  Canteen get _canteen => _ref.read(currentCanteen);

  void changeLocation(int id) {
    _canteen.vydejna = id;
  }

  int getLocation() => _canteen.vydejna;

  /// Gets [Jidelnicek] for a specified day
  /// Can throw:
  ///
  /// [CanteenErrors.needToLogin] - A user is not logged in
  ///
  /// [CanteenErrors.noInternetConnection] - The user doesn't have an internet connection
  ///
  /// [CanteenErrors.unsuportedFeature] - The feature is not supported by current icanteen version
  Future<Jidelnicek?> getDailyMenu(DateTime date) async {
    // Check for internet connectivity
    if (!await InternetConnectionChecker.instance.hasConnection) {
      return Future.error(CanteenErrors.noInternetConnection);
    }

    Jidelnicek? menu;
    try {
      menu = await _canteen.jidelnicekDen(den: date.normalize);
    } catch (e) {
      if (!await InternetConnectionChecker.instance.hasConnection) return Future.error(CanteenErrors.noInternetConnection);
      if (e == CanteenLibExceptions.jePotrebaSePrihlasit) return Future.error(CanteenErrors.needToLogin);
      if (e == CanteenLibExceptions.featureNepodporovana) return Future.error(CanteenErrors.unsuportedFeature);
    }
    return menu;
  }

  /// Gets [List] of [Jidelnicek] for the current month
  /// Can throw:
  ///
  /// [CanteenErrors.needToLogin] - A user is not logged in
  ///
  /// [CanteenErrors.noInternetConnection] - The user doesn't have an internet connection
  ///
  /// [CanteenErrors.unsuportedFeature] - The feature is not supported by current icanteen version
  Future<List<Jidelnicek>?> getMonthlyMenu() async {
    // Check for internet connectivity
    if (!await InternetConnectionChecker.instance.hasConnection) {
      return Future.error(CanteenErrors.noInternetConnection);
    }

    List<Jidelnicek>? menu;
    try {
      menu = await _canteen.jidelnicekMesic();
    } catch (e) {
      if (!await InternetConnectionChecker.instance.hasConnection) return Future.error(CanteenErrors.noInternetConnection);
      if (e == CanteenLibExceptions.jePotrebaSePrihlasit) return Future.error(CanteenErrors.needToLogin);
      if (e == CanteenLibExceptions.featureNepodporovana) return Future.error(CanteenErrors.unsuportedFeature);
    }
    return menu;
  }

  /// Gets the current marketplace
  /// Can throw:
  ///
  /// [CanteenErrors.needToLogin] - A user is not logged in
  ///
  /// [CanteenErrors.noInternetConnection] - The user doesn't have an internet connection
  ///
  /// [CanteenErrors.unsuportedFeature] - The feature is not supported by current icanteen version
  Future<List<Burza>> getMarketplace() async {
    // Check for internet connectivity
    if (!await InternetConnectionChecker.instance.hasConnection) {
      return Future.error(CanteenErrors.noInternetConnection);
    }

    List<Burza> menu = <Burza>[];
    try {
      menu = await _canteen.ziskatBurzu();
    } catch (e) {
      if (!await InternetConnectionChecker.instance.hasConnection) return Future.error(CanteenErrors.noInternetConnection);
      if (e == CanteenLibExceptions.jePotrebaSePrihlasit) return Future.error(CanteenErrors.needToLogin);
      if (e == CanteenLibExceptions.featureNepodporovana) return Future.error(CanteenErrors.unsuportedFeature);
    }
    return menu;
  }
}
