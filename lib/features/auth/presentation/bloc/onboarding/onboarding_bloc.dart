import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingRepository repository;

  OnboardingBloc({required this.repository}) : super(const OnboardingState()) {
    on<CheckOnboardingStatus>(_onCheckOnboardingStatus);
    on<CompleteOnboarding>(_onCompleteOnboarding);
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingPageInitialized>(_onPageInitialized);
  }

  Future<void> _onCheckOnboardingStatus(
    CheckOnboardingStatus event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final isCompleted = await GetHasCompletedOnboarding(repository).call();
      emit(state.copyWith(isCompleted: isCompleted, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onCompleteOnboarding(
    CompleteOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      await SetHasCompletedOnboarding(repository).call(true);
      emit(state.copyWith(isCompleted: true, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onPageInitialized(
    OnboardingPageInitialized event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(currentIndex: 0));
  }

  Future<void> _onPageChanged(
    OnboardingPageChanged event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(currentIndex: event.index));
  }
}
