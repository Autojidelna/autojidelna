import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/shared/providers/disable_interactions_provider.dart';
import 'package:autojidelna/shared/theme/app_themes.dart';
import 'package:autojidelna/shared/theme/application/theme_notifier.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:autojidelna/features/onboarding/onboarding.dart';
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';
import 'package:autojidelna/features/onboarding/application/onboarding_providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:expandable_page_view/expandable_page_view.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, this.steps, this.onCompletedCallback});
  final List<OnboardingStep>? steps;
  final void Function(bool onSuccess)? onCompletedCallback;

  @override
  Widget build(BuildContext context) => ProviderScope(
        overrides: [
          onboardingInitialStepsProvider.overrideWithValue(steps ?? Onboarding.defaultSteps),
          onboardingStepsProvider,
          onboardingFormKeyProvider,
          onboardingFocusNodeFocusProvider,
          onboardingHasFocusProvider,
          onboardingTextFieldStateProvider,
        ],
        child: _OnboardingPageContent(onCompletedCallback: onCompletedCallback),
      );
}

class _OnboardingPageContent extends ConsumerStatefulWidget {
  const _OnboardingPageContent({required this.onCompletedCallback});
  final void Function(bool onSuccess)? onCompletedCallback;

  @override
  ConsumerState<_OnboardingPageContent> createState() => __OnboardingPageContentState();
}

class __OnboardingPageContentState extends ConsumerState<_OnboardingPageContent> {
  int _pageIndex = 0;

  void updatePageIndex(int value) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _pageIndex = value);
      });

  void _nextPage(OnboardingStep currentPage, bool isLastPage) async {
    if (!await currentPage.onNextPage(context, ref)) return;
    if (!isLastPage) return Onboarding.nextPage();

    if (!mounted) return;
    if (widget.onCompletedCallback == null) {
      context.router.replaceAll([const RouterRoute()]);
    } else {
      widget.onCompletedCallback!(true);
    }
  }

  void _previousPage(OnboardingStep currentPage, bool isFirstPage) async {
    if (!await currentPage.onPreviousPage(context, ref)) return;
    if (!isFirstPage) return Onboarding.previousPage();

    if (!mounted) return;
    context.router.maybePop();
  }

  @override
  void initState() {
    super.initState();
    Onboarding.pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    Onboarding.pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;
    bool canNavigateBack = ref.read(userProvider).user != null;
    ThemeData theme = Theme.of(context);

    final steps = ref.watch(onboardingStepsProvider);
    final int clampedIndex = _pageIndex.clamp(0, steps.length - 1);
    final bool isFirstPage = clampedIndex == 0;
    final bool isLastPage = clampedIndex == steps.length - 1;
    final OnboardingStep currentPage = steps[clampedIndex];

    return PopScope(
      canPop: isFirstPage,
      child: Scaffold(
        appBar: AppBar(forceMaterialTransparency: true, automaticallyImplyLeading: false),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweenAnimationBuilder<double>(
                // visible -> collapsed
                tween: Tween<double>(begin: 1, end: ref.watch(onboardingHasFocusProvider) ? 0 : 1),
                duration: Durations.medium1,
                curve: Curves.easeOut,
                builder: (_, value, child) {
                  return Align(
                    alignment: Alignment.topLeft,
                    heightFactor: value, // shrink height with animation
                    child: Transform.translate(
                      offset: Offset(0, -55 * (1 - value)), // move up while shrinking
                      child: Opacity(opacity: value, child: child),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.rocket_launch_outlined, size: 55, color: theme.colorScheme.primary),
                ),
              ),
              ListTile(
                title: Text(l10n.welcome, style: theme.textTheme.displaySmall),
                subtitle: Text(currentPage.description(context), style: theme.textTheme.titleMedium),
              ),
              const CustomDivider(height: 32),
              Card(
                child: ExpandablePageView(
                  controller: Onboarding.pageController,
                  animationDuration: Durations.medium1,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: updatePageIndex,
                  children: steps.map((e) => e as Widget).toList(),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Row(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: (canNavigateBack || !isFirstPage) ? 1 : 0), // 0 = hidden, 1 = visible
                duration: Durations.medium1,
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: value,
                    child: Transform.translate(
                      offset: Offset((value - 1) * 60, 0), // slide in from left
                      child: Opacity(opacity: value, child: child),
                    ),
                  );
                },
                child: FilledButton(
                  style: theme.filledButtonTheme.style!.copyWith(
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (states) => AppThemes.backgroundColorWidgetState(
                        states,
                        theme.colorScheme,
                        ref.read(themeProvider).amoledMode,
                        primaryColor: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                  onPressed: ref.watch(disableInteractions) ? null : () => _previousPage(currentPage, isFirstPage),
                  child: const Icon(Icons.arrow_back_outlined),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  onPressed: ref.watch(disableInteractions) ? null : () => _nextPage(currentPage, isLastPage),
                  child: Text(currentPage.buttonText(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
