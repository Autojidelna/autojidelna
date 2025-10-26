import 'package:autojidelna/core/remote-config/remote_config.dart';
import 'package:autojidelna/core/utils/url.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CanteenUrlPicker extends ConsumerWidget {
  const CanteenUrlPicker({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    ListTileThemeData listTileTheme = theme.listTileTheme;
    final rawUrls = ref.read(remoteConfigValues)[RemoteConfig.canteenUrls];
    Map<String, String> urls = rawUrls is Map ? Map<String, String>.from(rawUrls) : {};

    TextSpan highlightText(String text, String query, TextStyle? textStyle, bool enabled) {
      if (query.isEmpty) return TextSpan(text: text);

      final lowerText = text.toLowerCase();
      final start = lowerText.indexOf(query);
      if (start == -1) return TextSpan(text: text);

      final end = start + query.length;

      return TextSpan(
        children: [
          TextSpan(text: text.substring(0, start)),
          TextSpan(
            text: text.substring(start, end),
            style: textStyle!.copyWith(color: theme.colorScheme.primary.withAlpha(enabled ? 255 : 100)),
          ),
          TextSpan(text: text.substring(end)),
        ],
      );
    }

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (_, urlController, _) {
        final query = urlController.text.trim().toLowerCase();
        final allEntries = urls.entries.toList();

        // check if query perfectly matches any key or value
        final hasPerfectMatch = allEntries.any((entry) => entry.key.toLowerCase() == query || entry.value.toLowerCase() == query);

        final filteredUrls = query.isEmpty || hasPerfectMatch
            ? allEntries
            : allEntries.where((e) => e.key.toLowerCase().contains(query) || e.value.toLowerCase().contains(query)).toList();

        return ListView.builder(
          shrinkWrap: true,
          itemCount: filteredUrls.length,
          itemBuilder: (_, index) {
            final entry = filteredUrls[index];
            final title = entry.key;
            final url = entry.value;

            bool enabled = !ref.watch(disableInteractions);

            return ListTile(
              enabled: enabled,
              title: Text.rich(highlightText(title, query, listTileTheme.titleTextStyle, enabled)),
              subtitle: Text.rich(highlightText(url, query, listTileTheme.subtitleTextStyle, enabled)),
              trailing: Url.clean(urlController.text) == url ? const Icon(Icons.check) : null,
              onTap: () => controller.text = url,
            );
          },
        );
      },
    );
  }
}
