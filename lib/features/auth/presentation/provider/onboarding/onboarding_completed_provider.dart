import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import 'onboarding_repository.dart';

final onboardingCompletedProvider =
    StateNotifierProvider<OnboardingCompletedNotifier, bool>((ref) {
  final repository = ref.watch(onboardingRepository);
  return OnboardingCompletedNotifier(repository);
});

class OnboardingCompletedNotifier extends StateNotifier<bool> {
  final OnboardingRepository _repository;

  OnboardingCompletedNotifier(this._repository) : super(false);

  Future<void> completeOnboarding() async {
    await SetHasCompletedOnboarding(_repository).call(true);
    state = true;
  }

  Future<bool> checkOnboardingStatus() async {
    return await GetHasCompletedOnboarding(_repository)();
  }
}
