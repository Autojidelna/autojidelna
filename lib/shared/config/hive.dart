import 'package:autojidelna/core/types/freezed/safe_account/safe_account.dart';

/// Hive boxes. Use these values to open a box.
class Boxes {
  /// Box used to store everything related to an account
  static String account(SafeAccount account) => _AccountBox.boxName(account);
  static const String appState = _AppStateBox.boxName;
  static const String notifications = _NotificationsBox.boxName;
  static const String settings = _SettingsBox.boxName;
}

/// These are the keys used to store values in Hive.
class HiveKeys {
  static final account = _AccountBox();
  static final appState = _AppStateBox();
  static final notifications = _NotificationsBox();
  static final settings = _SettingsBox();
}

class _AccountBox {
  static String boxName(SafeAccount account) => 'account_${account.username}_${account.url}';

  String location(SafeAccount account) => 'location_${account.username}_${account.url}';
  String lastJidloDneCheck(SafeAccount account) => 'last_jidlo_dne_check_${account.username}_${account.url}';
  String nemateObjednanoNotifications(SafeAccount account) => 'ignore_objednat_${account.username}_${account.url}';
  String dailyFoodInfo(SafeAccount account) => 'send_dish_info_${account.username}_${account.url}';
  String kreditNotifications(SafeAccount account) => 'ignore_kredit_${account.username}_${account.url}';
}

class _AppStateBox {
  static const String boxName = 'app_state';

  final String locale = 'locale';
  final String lastVersion = 'last_version';
  final String firstTime = 'first_time';
  final String url = 'last_used_icanteen_url';
  final String hideBurzaAlertDialog = 'hide_burza_alert_dialog';
  final String remoteConfigValues = 'remote_config_values'; // TODO: zmenit na seznam jidelen
}

class _NotificationsBox {
  static const String boxName = 'notifications';

  final String onlyNemateObjednanoNotifications = 'ignore_objednat_';
  final String onlykreditNotifications = 'ignore_kredit_';
}

class _SettingsBox {
  static const String boxName = 'settings';

  final String themeMode = 'theme_mode';
  final String themeStyle = 'theme_style';
  final String amoledMode = 'amoled_mode';
  final String listUi = 'list_ui';
  final String bigCalendarMarkers = 'big_calendar_markers';
  final String dateFormat = 'date_format';
  final String relTimeStamps = 'relative_time_stamps';
  final String skipWeekends = 'skip_weekends';
}
