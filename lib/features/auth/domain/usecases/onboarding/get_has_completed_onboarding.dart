import '../../domain.dart';

class GetHasCompletedOnboarding {
  final OnboardingRepository repository;

  GetHasCompletedOnboarding(this.repository);

  Future<bool> call() async {
    return await repository.getOnboardingStatus();
  }
}
