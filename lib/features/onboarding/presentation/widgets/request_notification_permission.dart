import 'package:autojidelna/l10n/l10n_context_extension.dart';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class RequestNotificationPermission extends StatefulWidget {
  const RequestNotificationPermission({super.key});

  @override
  State<RequestNotificationPermission> createState() => _RequestNotificationPermissionState();
}

class _RequestNotificationPermissionState extends State<RequestNotificationPermission> {
  bool notificationsEnabled = false;
  bool notificationsRefused = false;

  void checkNotificationPermissions() async {
    final status = await Permission.notification.status;
    if (status == PermissionStatus.provisional || status == PermissionStatus.granted) {
      setState(() {
        notificationsEnabled = true;
      });
    }
    if (status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied) {
      setState(() {
        notificationsRefused = true;
      });
    }
  }

  void askForPermission() async {
    checkNotificationPermissions();
    if (notificationsEnabled) return;

    if (!notificationsRefused) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    } else {
      await AwesomeNotifications().showNotificationConfigPage();
    }

    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (apnsToken != null) {}
    checkNotificationPermissions();
  }

  @override
  void initState() {
    super.initState();
    checkNotificationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;

    return ListTile(
      title: Text(l10n.allowNotifications),
      subtitle: Text(l10n.allowNotifcitaionsReasons),
      trailing: OutlinedButton(
        onPressed: notificationsEnabled ? null : askForPermission,
        child: notificationsEnabled
            ? const Icon(Icons.check, size: 25)
            : notificationsRefused
                ? const Icon(Icons.settings, size: 25)
                : Text(l10n.grant),
      ),
    );
  }
}
