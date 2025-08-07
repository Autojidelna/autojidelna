import 'package:autojidelna/app/app_providers.dart';
import 'package:autojidelna/core/firebase/remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Links {
  static final String autojidelna = Rmc.values[Rmc.autojidelnaLink];
  static const String repo = 'https://github.com/Autojidelna/autojidelna';
  static String currentVersionCode(WidgetRef ref) => '$repo/blob/v${ref.read(packageInfoProvider)!.version}';

  static final String privacyPolicy = '$autojidelna/cs/privacy-policy/';
  static const String email = 'info@appelevate.cz';
}
