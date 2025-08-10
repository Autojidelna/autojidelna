import 'package:autojidelna/shared/config/errors.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/core/types/freezed/safe_account.dart/safe_account.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:autojidelna/shared/config/hive.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/features/canteen/application/canteen.provider.dart';
import 'package:autojidelna/core/types/errors.dart';
import 'package:autojidelna/core/types/freezed/account/account.dart';
import 'package:autojidelna/shared/snackbars/show_internet_connection_snack_bar.dart';
import 'package:autojidelna/shared/utils/show_snack_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = ChangeNotifierProvider<LoginProvider>((ref) => LoginProvider());

class LoginProvider extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  final GlobalKey<FormState> urlForm = GlobalKey<FormState>();
  final GlobalKey<FormState> credentialsForm = GlobalKey<FormState>();

  bool _loggingIn = false;
  String? urlError;
  bool usernameError = false;
  String? passwordError;
  bool hidePassword = true;
  SafeAccount? _pickedAccount;

  LoginProvider() {
    setLastUrl();
  }

  bool get loggingIn => _loggingIn;
  SafeAccount? get pickedAccount => _pickedAccount;

  set loggingIn(bool value) {
    if (_loggingIn == value) return;
    _loggingIn = value;
    notifyListeners();
  }

  void setPickedAccount(SafeAccount account) {
    if (_pickedAccount == account) return;
    _pickedAccount = account;
    notifyListeners();
  }

  void changePasswordVisibility() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  void setLastUrl() {
    urlController.text = Hive.box(Boxes.appState).get(HiveKeys.appState.url, defaultValue: '');
  }

  Future<bool> login(BuildContext context) async {
    if (!credentialsForm.currentState!.validate()) return false;

    FocusManager.instance.primaryFocus?.unfocus();
    setErrors(null, null, null);
    bool value = false;
    _loggingIn = true;
    notifyListeners();

    final account = Account(
      username: usernameController.text,
      password: passwordController.text,
      url: urlController.text,
    );

    try {
      final ProviderContainer container = ProviderScope.containerOf(context);

      await container.read(userProvider).login(account);
      Hive.box(Boxes.appState).put(HiveKeys.appState.url, urlController.text);
      if (context.mounted) await container.read(canteenProvider).preIndexMenus();
      value = true;
    } catch (e) {
      if (context.mounted) handleAuthError(context, e);
    }
    _loggingIn = false;
    notifyListeners();
    return value;
  }

  void handleAuthError(BuildContext context, dynamic e) async {
    final l10n = context.l10n;
    switch (e) {
      case AuthErrors.noInternetConnection:
        bool retry = await showInternetConnectionSnackBar();
        if (retry && context.mounted) login(context);
        break;
      case AuthErrors.wrongCredentials:
        setErrors(l10n.errorsWrongCredentialsTextField, true, null);
        break;
      case AuthErrors.wrongUrl:
        setErrors(null, null, l10n.errorsWrongUrl);
        break;
      default:
        showErrorSnackBar(SnackBarAuthErrors.connectionFailed(l10n));
    }
  }

  void setErrors(String? passwordErr, bool? usernameErr, String? urlErr) {
    passwordError = passwordErr;
    usernameError = usernameErr ?? false;
    urlError = urlErr;
    notifyListeners();
  }
}
