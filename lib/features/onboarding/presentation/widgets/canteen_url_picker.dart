import 'dart:convert';

import 'package:autojidelna/core/utils/url.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/config/links.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class CanteenUrlPicker extends ConsumerWidget {
  const CanteenUrlPicker({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    ListTileThemeData listTileTheme = theme.listTileTheme;

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
            style: (textStyle ?? const TextStyle()).copyWith(color: theme.colorScheme.primary.withAlpha(enabled ? 255 : 100)),
          ),
          TextSpan(text: text.substring(end)),
        ],
      );
    }

    Column centeredText(String text) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(text, style: listTileTheme.subtitleTextStyle!.copyWith(fontWeight: listTileTheme.titleTextStyle!.fontWeight)),
              ),
            ),
          ),
        ],
      );
    }

    return FutureBuilder(
      future: http.get(Uri.parse(Links.remoteCanteenList)),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) return centeredText(context.l10n.loadingCanteens);
        if (asyncSnapshot.hasError || !asyncSnapshot.hasData) return centeredText(context.l10n.errorsLoadingData);

        // TODO: Make canteen ulrs more robust

        Map<String, String> urls = Map.castFrom(json.decode(asyncSnapshot.data!.body));

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
      },
    );
  }
}
