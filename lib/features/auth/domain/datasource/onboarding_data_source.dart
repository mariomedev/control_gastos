abstract class OnboardingDataSource {
  Future<void> setOnboardingStatus(bool isOnboarded);
  Future<bool> getOnboardingStatus();
}
