import 'dart:async';

import 'package:autojidelna/l10n/l10n_context_extension.dart';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class RequestNotificationPermission extends StatefulWidget {
  const RequestNotificationPermission({super.key});

  @override
  State<RequestNotificationPermission> createState() => _RequestNotificationPermissionState();
}

class _RequestNotificationPermissionState extends State<RequestNotificationPermission> with WidgetsBindingObserver {
  bool notificationsEnabled = false;
  bool notificationsRefused = false;
  PermissionStatus? lastStatus;

  void checkNotificationPermissions() async {
    PermissionStatus status = await Permission.notification.status;
    if (lastStatus == status) return;

    setState(() {
      notificationsEnabled = status.isProvisional || status.isGranted;
      notificationsRefused = status.isPermanentlyDenied;
      lastStatus = status;
    });
  }

  Future<void> askForPermission() async {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkNotificationPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    checkNotificationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;

    return ListTile(
      title: Text(l10n.notificationsAllow),
      subtitle: Text(l10n.notificationsAllowReasons),
      trailing: OutlinedButton(
        onPressed: notificationsEnabled ? null : askForPermission,
        child: notificationsEnabled
            ? const Icon(Icons.check, size: 25)
            : notificationsRefused && (lastStatus?.isPermanentlyDenied ?? false)
            ? const Icon(Icons.settings, size: 25)
            : Text(l10n.grant),
      ),
    );
  }
}
