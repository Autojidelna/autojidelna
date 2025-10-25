import 'dart:async';

import 'package:autojidelna/core/analytics/statistic_type.dart';
import 'package:autojidelna/core/utils/url.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hive_ce/hive.dart';

class AnalyticsService {
  AnalyticsService._();
  static final AnalyticsService instance = AnalyticsService._();

  void enabled(bool enabled) {
    unawaited(FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(enabled));
    if (!enabled) unawaited(FirebaseAnalytics.instance.resetAnalyticsData());
  }

  void addStatistic(StatisticType type) async {
    Box box = Hive.box(Boxes.analytics);

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

  void logCanteenUrl(String url, String? canteenVersion) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'login_url',
      parameters: {
        'url': Url.clean(url),
        'canteen_version': canteenVersion ?? 'Unavailable',
      },
    );
  }
}
