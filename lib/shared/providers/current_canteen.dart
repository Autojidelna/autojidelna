import 'package:autojidelna/core/analytics/analytics_service.dart';
import 'package:autojidelna/core/notifications/notification_channel_service.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/core/types/freezed/account/account.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:autojidelna/core/utils/url.dart';
import 'package:autojidelna/shared/providers/saved_accounts.dart';
import 'package:autojidelna/shared/services/credentials_service.dart';

import 'package:icanteenlib/canteenlib.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_canteen.g.dart';

@Riverpod(keepAlive: true)
class CurrentCanteen extends _$CurrentCanteen {
  @override
  Canteen? build() => null;

  void set(Canteen canteen) => state = canteen;

  /// Returns TRUE if the url is ok
  Future<bool> testCanteenUrl(String url) async {
    url = Url.clean(url);
    AnalyticsService.instance.logCanteenUrl(url, ref.read(currentCanteenProvider)?.verze);

    try {
      return Canteen(url).login('', '');
    } catch (_) {}
    return false;
  }

  /// Main logic for loging in.
  /// Can throw:
  ///
  /// [AuthErrors.connectionFailed] - Connection to the canteen server failed
  ///
  /// [AuthErrors.noInternetConnection] - The user doesn't have an internet connection
  ///
  /// [AuthErrors.wrongCredentials] - The user has entered incorrect credentials
  ///
  /// [AuthErrors.wrongUrl] - The user has entered an invalid URL
  Future<void> login(Account account, [bool saveToStorage = true]) async {
    Canteen instance = Canteen(Url.clean(account.url));

    try {
      // First login attempt (with cleaned URL)
      if (!await instance.login(account.username, account.password)) {
        return Future.error(AuthErrors.wrongCredentials);
      }
    } catch (e) {
      // Check for internet connectivity
      if (!await InternetConnectionChecker.instance.hasConnection) {
        return Future.error(AuthErrors.noInternetConnection);
      }

      if (e == CanteenLibExceptions.neplatneUrl) return Future.error(AuthErrors.wrongUrl);

      return Future.error(AuthErrors.connectionFailed);
    }

    state = instance;

    if (!saveToStorage) return;
    NotificationChannelService().createChannelsForUser(SafeAccount.fromAccount(account));
    ref.read(savedAccountsProvider.notifier).add(account);
  }

  Future<void> loginFromStorage() async {
    Account? account = await CredentialsService.getLastUsed();
    if (account == null) return Future.error(AuthErrors.accountNotFound);

    await login(account, false);
  }

  void logout(SafeAccount safeAccount, [bool removeFromStorage = false]) async {
    state = null;

    if (!removeFromStorage) return;
    NotificationChannelService().removeChannelsForUser(safeAccount);
    ref.read(savedAccountsProvider.notifier).remove(safeAccount);
  }

  Future<void> changeAccount(SafeAccount safeAccount) async {
    await CredentialsService.setLastUsed(safeAccount);
    await loginFromStorage();
  }
}
