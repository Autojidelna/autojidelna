import 'package:autojidelna/core/remote-config/remote_config.dart';
import 'package:autojidelna/core/utils/url.dart';
import 'package:autojidelna/features/onboarding/application/onboarding_providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CanteenUrlPicker extends ConsumerWidget {
  const CanteenUrlPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    ListTileThemeData listTileTheme = theme.listTileTheme;
    final rawUrls = ref.read(remoteConfigValues)[RemoteConfig.canteenUrls];
    Map<String, String> urls = rawUrls is Map ? Map<String, String>.from(rawUrls) : {};

    TextSpan highlightText(String text, String query, TextStyle? textStyle) {
      if (query.isEmpty) return TextSpan(text: text, style: textStyle);

      final lowerText = text.toLowerCase();
      final start = lowerText.indexOf(query);
      if (start == -1) return TextSpan(text: text, style: textStyle);

      final end = start + query.length;

      return TextSpan(
        children: [
          TextSpan(text: text.substring(0, start), style: textStyle),
          TextSpan(text: text.substring(start, end), style: textStyle!.copyWith(color: theme.colorScheme.primary)),
          TextSpan(text: text.substring(end), style: textStyle),
        ],
      );
    }

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: ref.read(onboardingTextFieldControllerProvider(OnboardingTextFields.url)),
      builder: (_, urlController, ___) {
        final query = urlController.text.trim().toLowerCase();
        final allEntries = urls.entries.toList();

        // check if query perfectly matches any key or value
        final hasPerfectMatch = allEntries.any(
          (entry) => entry.key.toLowerCase() == query || entry.value.toLowerCase() == query,
        );

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

            return ListTile(
              title: RichText(text: highlightText(title, query, listTileTheme.titleTextStyle), textScaler: MediaQuery.of(context).textScaler),
              subtitle: RichText(text: highlightText(url, query, listTileTheme.subtitleTextStyle), textScaler: MediaQuery.of(context).textScaler),
              trailing: Url.clean(urlController.text) == url ? const Icon(Icons.check) : null,
              onTap: () => ref.read(onboardingTextFieldControllerProvider(OnboardingTextFields.url)).text = url,
            );
          },
        );
      },
    );
  }
}
