// Purpose: stores constants used throughout the app.

import 'package:autojidelna/app/app_providers.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/src/_global/providers/remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  static final String autojidelna = Rmc.values[Rmc.autojidelnaLink];
  static const String repo = 'https://github.com/Autojidelna/autojidelna';
  static String currentVersionCode(WidgetRef ref) => '$repo/blob/v${ref.read(packageInfoProvider)!.version}';

  static final String privacyPolicy = '$autojidelna/cs/privacy-policy/';
  static const String email = 'info@appelevate.cz';
}
