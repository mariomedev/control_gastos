abstract class OnboardingRepository {
  Future<void> setOnboardingStatus(bool isOnboarded);
  Future<bool> getOnboardingStatus();
}
