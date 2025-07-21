import '../../domain/domain.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingDataSource dataSource;

  OnboardingRepositoryImpl(this.dataSource);
  @override
  Future<bool> getOnboardingStatus() async {
    return await dataSource.getOnboardingStatus();
  }

  @override
  Future<void> setOnboardingStatus(bool isOnboarded) async {
    await dataSource.setOnboardingStatus(isOnboarded);
  }
}
