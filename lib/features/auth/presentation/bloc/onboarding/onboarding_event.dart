part of 'onboarding_bloc.dart';

abstract class OnboardingEvent {
  const OnboardingEvent();
}

class CheckOnboardingStatus extends OnboardingEvent {
  const CheckOnboardingStatus();
}

class CompleteOnboarding extends OnboardingEvent {
  const CompleteOnboarding();
}

class OnboardingPageChanged extends OnboardingEvent {
  final int index;

  const OnboardingPageChanged(this.index);
}

class OnboardingPageInitialized extends OnboardingEvent {
  const OnboardingPageInitialized();
}
