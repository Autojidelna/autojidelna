// Purpose: Login screen for the app

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:autojidelna/local_imports.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:localization/localization.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    super.key,
    required this.setHomeWidget,
  });
  final Function(Widget widget) setHomeWidget;
  // Static is fix for keyboard disapearing when this screen is pushed (problem with rebuilding the widget)
  static final _formKey = GlobalKey<FormState>();
  // Without static the text in the textfields would be deleted for the same reasons.
  static final _usernameController = TextEditingController();
  static final _passwordController = TextEditingController();
  static final _urlController = TextEditingController();

  /// First value is error text, second is if it the password is visible
  final ValueNotifier<List<dynamic>> passwordNotifier = ValueNotifier([null, false]);
  final ValueNotifier<String?> urlErrorText = ValueNotifier(null);
  final ValueNotifier<bool> loggingIn = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    if (!loginScreenVisible) {
      setLastUrl();
      _usernameController.text = '';
      _passwordController.text = '';
      loginScreenVisible = true;
    }
    return formScaffold(context);
  }

  Scaffold formScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            Texts.aboutAppName.i18n(),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          loginForm(context),
        ],
      ),
    );
  }

  void _setErrorText(String text, LoginFormErrorField field) {
    switch (field) {
      case LoginFormErrorField.password:
        passwordNotifier.value = [text, passwordNotifier.value[1]];
        urlErrorText.value = null;
        break;
      case LoginFormErrorField.url:
        urlErrorText.value = text;
        passwordNotifier.value = [null, passwordNotifier.value[1]];
        break;
    }
  }

  void setLastUrl() async {
    _urlController.text = await loggedInCanteen.readData(Prefs.url) ?? "";
  }

  Form loginForm(context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ValueListenableBuilder(
                  valueListenable: urlErrorText,
                  builder: (ctx, value, child) {
                    return TextFormField(
                      controller: _urlController,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: Texts.loginUrlFieldLabel.i18n(),
                        errorText: value,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return Texts.loginUrlFieldHint.i18n();
                        }
                        return null;
                      },
                    );
                  }),
            ),
            AutofillGroup(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      autofillHints: const [AutofillHints.username],
                      controller: _usernameController,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      decoration: InputDecoration(labelText: Texts.loginUserFieldLabel.i18n()),
                      validator: (value) {
                        if (value == null || value.isEmpty) return Texts.loginUserFieldHint.i18n();
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ValueListenableBuilder(
                      valueListenable: passwordNotifier,
                      builder: (context, value, child) {
                        return TextFormField(
                          controller: _passwordController,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.password],
                          obscureText: value[1] ? false : true,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: Texts.loginPasswordFieldLabel.i18n(),
                            errorText: value[0],
                            suffixIcon: IconButton(
                              onPressed: () => passwordNotifier.value = [passwordNotifier.value[0], !passwordNotifier.value[1]],
                              icon: Icon(value[1] ? Icons.visibility : Icons.visibility_off),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return Texts.loginPasswordFieldHint.i18n();
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            loginSubmitButton(context),
            RichText(
              text: TextSpan(
                text: Texts.dataCollectionAgreement.i18n(),
                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                children: [
                  TextSpan(
                    text: Texts.moreInfo.i18n(),
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(onlyAnalytics: true),
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container loginSubmitButton(context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 60,
      width: 400,
      child: ElevatedButton(
        onPressed: loggingIn.value ? null : () => loginFieldCheck(context),
        style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
        child: ValueListenableBuilder(
          valueListenable: loggingIn,
          builder: (context, value, child) {
            if (value) return CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary);
            return Text(Texts.loginButton.i18n());
          },
        ),
      ),
    );
  }

  void loginFieldCheck(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form fields.
      _formKey.currentState!.save();
      loggingIn.value = true;
      String url = _urlController.text;
      try {
        bool login = await loggedInCanteen.addAccount(_urlController.text, _usernameController.text, _passwordController.text);
        if (login) {
          loggedInCanteen.saveData(Prefs.url, url);
          try {
            changeDate(newDate: DateTime.now());
            if (context.mounted) {
              Navigator.maybeOf(context)!.popUntil((route) => route.isFirst);
            }
          } catch (e) {
            //if it is not connected we don't have to do anything
          }
          setHomeWidget(MainAppScreen(setHomeWidget: setHomeWidget));
        } else {
          _setErrorText(Texts.errorsBadPassword.i18n(), LoginFormErrorField.password);
        }
      } catch (e) {
        bool connected = await InternetConnectionChecker().hasConnection;
        if (!connected) {
          _setErrorText(Texts.errorsBadConnection.i18n(), LoginFormErrorField.url);
        } else {
          try {
            //make a get request to the server to see if it is reachable
            url = url.replaceAll('https://', '');
            url = url.replaceAll('http://', '');
            url = url.split('/')[0];
            await http.get(Uri.parse('https://$url'));
            _setErrorText(Texts.errorsBadConnection.i18n(), LoginFormErrorField.url);
          } catch (e) {
            try {
              url = url.replaceAll('https://', 'http://');
              await http.get(Uri.parse('http://$url'));
              _setErrorText(Texts.errorsBadConnection, LoginFormErrorField.url);
            } catch (e) {
              _setErrorText(Texts.errorsBadUrl, LoginFormErrorField.url);
            }
          }
        }
      }
      loggingIn.value = false;
      loginScreenVisible = false;
    }
  }
}
