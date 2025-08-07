import 'dart:async';

import 'package:autojidelna/core/analytics/statistic_type.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hive/hive.dart';

// TODO
class AnalyticsService {
  static void enabled(bool enabled) {
    unawaited(FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(enabled));
    if (!enabled) unawaited(FirebaseAnalytics.instance.resetAnalyticsData());
  }

  void addStatistic(StatisticType type) async {
    Box box = Hive.box(Boxes.analytics);

    // EXAMPLE
    // FirebaseAnalytics.instance.logEvent(name: 'logout');

    switch (type) {
      //default case
      case StatisticType.order:
        int pocetStatistiky = box.get(HiveKeys.analytics.statistikaObjednavka, defaultValue: 0);
        pocetStatistiky++;
        //if (analyticsEnabledGlobally && analytics != null) analytics!.logEvent(name: 'objednavka', parameters: {'pocet': pocetStatistiky});

        box.put(HiveKeys.analytics.statistikaObjednavka, pocetStatistiky);
        break;
      case StatisticType.auto:
        int pocetStatistiky = box.get(HiveKeys.analytics.statistikaAuto, defaultValue: 0);
        pocetStatistiky++;
        box.put(HiveKeys.analytics.statistikaAuto, pocetStatistiky);
        break;
      case StatisticType.burzaCatcher:
        int pocetStatistiky = box.get(HiveKeys.analytics.statistikaBurzaCatcher, defaultValue: 0);
        pocetStatistiky++;
        box.put(HiveKeys.analytics.statistikaBurzaCatcher, pocetStatistiky);
        break;
    }
  }
}
