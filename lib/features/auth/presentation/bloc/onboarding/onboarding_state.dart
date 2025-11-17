part of 'onboarding_bloc.dart';

class OnboardingState {
  final bool isCompleted;
  final bool isLoading;
  final int currentIndex;

  const OnboardingState({
    this.isCompleted = false,
    this.isLoading = false,
    this.currentIndex = 0,
  });

  OnboardingState copyWith({
    bool? isCompleted,
    bool? isLoading,
    int? currentIndex,
  }) {
    return OnboardingState(
      isCompleted: isCompleted ?? this.isCompleted,
      isLoading: isLoading ?? this.isLoading,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
