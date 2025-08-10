import 'package:autojidelna/core/remote-config/remote_config.dart';
import 'package:autojidelna/features/auth/data/login.provider.dart';
import 'package:autojidelna/core/utils/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CanteenUrlPicker extends ConsumerWidget {
  const CanteenUrlPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoginProvider provider = ref.read(loginProvider);
    final rawUrls = ref.read(remoteConfigValues)[RemoteConfig.canteenUrls];

    Map<String, String> urls;

    if (rawUrls is Map) {
      urls = Map<String, String>.from(rawUrls);
    } else {
      urls = {};
    }
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: provider.urlController,
      builder: (_, urlController, ___) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: urls.length,
          itemBuilder: (_, index) {
            String title = urls.entries.elementAt(index).key;
            String url = urls.entries.elementAt(index).value;

            return ListTile(
              title: Text(title),
              subtitle: Text(url),
              trailing: Url.clean(urlController.text) == url ? const Icon(Icons.check) : null,
              onTap: () => provider.urlController.text = url,
            );
          },
        );
      },
    );
  }
}
