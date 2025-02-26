// Purpose: stores constants used throughout the app.

import 'package:autojidelna/src/_global/app.dart';
import 'package:autojidelna/src/types/freezed/safe_account.dart/safe_account.dart';

class NotificationIds {
  static String kreditChannel(SafeAccount account) => 'kredit_channel_${account.username}_${account.url}';
  static String objednanoChannel(SafeAccount account) => 'objednano_channel_${account.username}_${account.url}';
  static String dnesniJidloChannel(SafeAccount account) => 'jidlo_channel_${account.username}_${account.url}';
  static String channelGroup(SafeAccount account) => 'channel_group_${account.username}_${account.url}';
  static String get channelGroupElse => 'channel_group_else';
  static String get channelElse => 'else_channel';
  static String get payloadUser => 'user';
  static String get payloadIndex => 'index';
  static String get payloadIndexDne => 'indexDne';
  static String objednatButton(SafeAccount account) => 'objednat_${account.username}_${account.url}';
  static String get onlyObjednatButton => 'objednat_';
}

class Links {
  static String get autojidelna => 'https://autojidelna.cz';
  static String get repo => 'https://github.com/App-Elevate/Autojidelna';
  static String get currentVersionCode => '$repo/blob/v${App.packageInfo.version}';

  static String get privacyPolicy => '$autojidelna/cs/privacy-policy/';
  static String get email => 'info@appelevate.cz';
}
