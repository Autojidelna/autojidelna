import 'package:autojidelna/app/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Links {
  static const String autojidelna = 'https://autojidelna.cz';
  static const String repo = 'https://github.com/Autojidelna/autojidelna';
  static String currentVersionCode(WidgetRef ref) => '$repo/blob/v${ref.read(packageInfoProvider)!.version}';

  static const String privacyPolicy = '$autojidelna/cs/privacy-policy/';
  static const String email = 'info@appelevate.cz';
}
