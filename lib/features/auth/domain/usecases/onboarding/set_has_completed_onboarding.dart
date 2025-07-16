import '../../domain.dart';

class SetHasCompletedOnboarding {
  final OnboardingRepository repository;

  SetHasCompletedOnboarding(this.repository);

  Future<void> call(bool hasCompleted) async {
    await repository.setOnboardingStatus(hasCompleted);
  }
}
