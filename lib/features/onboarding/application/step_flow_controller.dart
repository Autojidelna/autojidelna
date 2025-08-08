import 'package:autojidelna/features/onboarding/presentation/onboarding_cards/account_picker_onboarding.dart';
import 'package:autojidelna/features/onboarding/presentation/onboarding_cards/canteen_url_onboarding.dart';
import 'package:autojidelna/features/onboarding/presentation/onboarding_cards/login_onboarding.dart';
import 'package:autojidelna/features/onboarding/presentation/onboarding_cards/permissions_onboarding.dart';
import 'package:autojidelna/features/onboarding/presentation/onboarding_cards/theme_onboarding.dart';
import 'package:autojidelna/features/onboarding/domain/onboarding_step.dart';

class StepFlowController {
  StepFlowController._internal();

  static final StepFlowController _instance = StepFlowController._internal();

  static StepFlowController get instance => _instance;

  final List<OnboardingStep> _defaultPages = [
    const ThemeOnboarding(),
    const PermissionsOnboarding(),
  ];

  final List<OnboardingStep> _loginFlowPages = [
    const CanteenUrlOnboarding(),
    const LoginOnboarding(),
  ];

  final List<OnboardingStep> _accountPickerFlowPages = [
    const AccountPickerOnboarding(),
  ];

  final List<OnboardingStep> _pages = [
    const ThemeOnboarding(),
    const PermissionsOnboarding(),
  ];

  int _currentPageIndex = 0;

  bool get isFirstPage => _currentPageIndex == 0;

  bool get isLastPage => _currentPageIndex >= pages.length - 1;

  OnboardingStep get currentPage => pages[_currentPageIndex];

  List<OnboardingStep> get pages => List.unmodifiable(_pages);
  List<OnboardingStep> get loginFlowPage => List.unmodifiable(_loginFlowPages);
  List<OnboardingStep> get accountPickerFlowPages => List.unmodifiable(_accountPickerFlowPages);

  void setCurrentPageIndex(int index) {
    _currentPageIndex = index;
  }

  void addSteps(List<OnboardingStep> newSteps) {
    _pages.addAll(newSteps);
  }

  void clear() {
    _pages.clear();
    _currentPageIndex = 0;
  }

  void reset() {
    clear();
    addSteps(_defaultPages);
  }

  void setLoginFlow() {
    clear();
    addSteps(_loginFlowPages);
  }

  void setAccountPickerFlow() {
    clear();
    addSteps(_accountPickerFlowPages);
  }
}
