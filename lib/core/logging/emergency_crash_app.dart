import 'package:autojidelna/app/app.dart';
import 'package:autojidelna/core/logging/local_logger.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/config/links.dart';
import 'package:autojidelna/shared/theme/app_themes.dart';
import 'package:autojidelna/shared/theme/domain/color_style.dart';
import 'package:autojidelna/shared/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// TODO: improce

class EmergencyCrashApp extends StatelessWidget {
  const EmergencyCrashApp({super.key, required this.error, this.stack});

  final String error;
  final String? stack;

  @override
  Widget build(BuildContext context) {
    ColorStyle colorStyle = AppThemes.colorStyles[ThemeStyle.defaultStyle]!;
    ColorScheme scheme = AppThemes.colorSchemeLight.copyWith(primary: colorStyle.primaryLight, secondary: colorStyle.secondaryLight);
    ColorScheme schemeDark = AppThemes.colorSchemeDark.copyWith(primary: colorStyle.primaryLight, secondary: colorStyle.secondaryLight);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.theme(scheme),
      darkTheme: AppThemes.theme(schemeDark),
      themeMode: ThemeMode.system,
      locale: L10n.supportedLocales.first,
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: L10n.localizationsDelegates,
      home: EmergencyCrashPage(error: error, stack: stack),
    );
  }
}

class EmergencyCrashPage extends StatelessWidget {
  const EmergencyCrashPage({super.key, required this.error, this.stack});

  final String error;
  final String? stack;

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle errorTitleTextStyley = AppThemes.textTheme.titleSmall!.copyWith(
      fontFamily: Fonts.shareTechMono,
      color: Theme.of(context).colorScheme.error,
    );
    final TextStyle errorBodyTextStyley = AppThemes.textTheme.bodySmall!.copyWith(fontFamily: Fonts.shareTechMono);

    final buttonStyle = Theme.of(context).filledButtonTheme.style!.copyWith(
      backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surfaceContainerHighest),
      elevation: WidgetStatePropertyAll(2),
    );

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.appCrashed), backgroundColor: Theme.of(context).colorScheme.error, automaticallyImplyLeading: false),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Column(
                children: [
                  Text(context.l10n.appFailedToWork, style: AppThemes.textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Text(context.l10n.pleaseReportError, style: AppThemes.textTheme.titleMedium),
                ],
              ),
            ),
            ExpansionTile(
              collapsedTextColor: Colors.amber,
              textColor: Colors.amber,
              title: Text(context.l10n.howToReport),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              childrenPadding: EdgeInsets.symmetric(horizontal: 16),
              shape: Border(),
              children: [Text(context.l10n.howToReport1), Text(context.l10n.howToReport2)],
            ),
            SizedBox(height: 16),
            Expanded(
              child: Card.outlined(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: SelectionArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(error.trim(), style: errorTitleTextStyley),
                        const Divider(),
                        Text(stack?.trim() ?? context.l10n.stackTraceNotProvided, style: errorBodyTextStyley),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Builder(
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 32,
                      child: FilledButton(
                        style: buttonStyle,
                        onPressed: () async {
                          await LocalLogger.downloadLogFile();
                          await _launchUrl(Links.issues);
                        },
                        child: Text(context.l10n.reportOnGithub),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 32,
                      child: FilledButton(
                        style: buttonStyle,
                        onPressed: () async {
                          await LocalLogger.downloadLogFile().then((_) async => await _launchUrl(Links.reportEmail));
                          // await _launchUrl(Links.reportEmail);
                        },
                        child: Text(context.l10n.reportOnEmail),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextButton(onPressed: () => App.restart(context), child: Text(context.l10n.restartApp)),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  static void show(String error, StackTrace? stack) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      BuildContext? context = App.navigatorKey.currentContext;

      if (context == null) {
        // Run stripped down app to display error message
        runApp(EmergencyCrashApp(error: error, stack: stack?.toString()));
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => EmergencyCrashPage(error: error, stack: stack.toString()),
        ),
      );
    });
  }
}
