import 'package:auto_route/auto_route.dart';
import 'package:autojidelna/app/routing/app_router.gr.dart';
import 'package:autojidelna/features/onboarding/presentation/onboarding_cards/account_picker_onboarding.dart';
import 'package:autojidelna/features/onboarding/application/step_flow_controller.dart';
import 'package:autojidelna/shared/providers/account.provider.dart';
import 'package:autojidelna/features/auth/data/login.provider.dart';
import 'package:autojidelna/l10n/l10n_context_extension.dart';
import 'package:autojidelna/shared/widgets/custom_divider.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key, this.onCompletedCallback});
  final void Function(bool onSuccess)? onCompletedCallback;

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  late final PageController _pageController;
  late final StepFlowController _stepFlow;

  void _nextPage() async {
    if (!await _stepFlow.currentPage.onNextPage(context, ref: ref)) return;
    if (!_stepFlow.isLastPage) {
      _pageController.nextPage(
        duration: Durations.medium1,
        curve: Curves.easeInOut,
      );
      return;
    }

    if (!mounted) return;
    if (widget.onCompletedCallback == null) {
      context.router.replaceAll([const RouterRoute()]);
    } else {
      widget.onCompletedCallback!(true);
    }
  }

  void _previousPage() async {
    if (_stepFlow.isFirstPage) {
      context.router.maybePop();
      return;
    }

    _pageController.previousPage(
      duration: Durations.medium1,
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _stepFlow = StepFlowController.instance;
  }

  @override
  void dispose() {
    super.dispose();
    _stepFlow.reset();
  }

  @override
  Widget build(BuildContext context) {
    final L10n l10n = context.l10n;
    bool canNavigateBack = ref.read(userProvider).user != null;
    ThemeData theme = Theme.of(context);

    return PopScope(
      canPop: _stepFlow.isFirstPage,
      child: Scaffold(
        appBar: AppBar(forceMaterialTransparency: true, automaticallyImplyLeading: false),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.rocket_launch_outlined, size: 55, color: theme.colorScheme.primary),
              ),
              ListTile(
                title: Text(l10n.welcome, style: theme.textTheme.displaySmall),
                subtitle: Text(_stepFlow.currentPage.description(context), style: theme.textTheme.titleMedium),
              ),
              const CustomDivider(height: 32),
              Card(
                child: ExpandablePageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) => setState(() => _stepFlow.setCurrentPageIndex(value)),
                  children: _stepFlow.pages.map((e) => e as Widget).toList(),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Row(
            children: [
              if (canNavigateBack || !_stepFlow.isFirstPage)
                FilledButton(
                  style: theme.filledButtonTheme.style!.copyWith(backgroundColor: WidgetStatePropertyAll(theme.disabledColor)),
                  onPressed: ref.watch(loginProvider).loggingIn ? null : _previousPage,
                  child: const Icon(Icons.arrow_back_outlined),
                ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  onPressed: ref.watch(loginProvider).loggingIn ||
                          (_stepFlow.pages.last is AccountPickerOnboarding && _stepFlow.isLastPage && ref.watch(loginProvider).pickedAccount == null)
                      ? null
                      : _nextPage,
                  child: Text(_stepFlow.currentPage.buttonText(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
