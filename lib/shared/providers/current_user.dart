import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/core/types/freezed/user/user.dart';
import 'package:autojidelna/shared/providers/current_canteen.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:icanteenlib/canteenlib.dart';

part 'current_user.g.dart';

@Riverpod(keepAlive: true)
class CurrentSafeAccount extends _$CurrentSafeAccount {
  @override
  SafeAccount? build() {
    return null;
  }

  void set(SafeAccount safeAccount) => state = safeAccount;
}

@Riverpod(keepAlive: true)
FutureOr<User?> currentUser(Ref ref) async {
  Canteen? canteen = ref.watch(currentCanteenProvider);
  SafeAccount? safeAccount = ref.watch(currentSafeAccountProvider);

  if (canteen == null || safeAccount == null) return null;

  return User(
    accountData: safeAccount,
    data: await _fetchUserData(canteen, safeAccount.username),
    canteenLocations: (await canteen.jidelnicekDen()).vydejny,
  );
}

Future<Uzivatel> _fetchUserData(Canteen canteen, String username) async {
  return canteen.missingFeatures.contains(Features.ziskatUzivatele) ? Uzivatel(uzivatelskeJmeno: username) : await canteen.ziskejUzivatele();
}
