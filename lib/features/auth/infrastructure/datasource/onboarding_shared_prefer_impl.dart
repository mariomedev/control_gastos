import '../../../../core/core.dart';
import '../../domain/domain.dart';

class OnboardingSharedPreferImpl implements OnboardingDataSource {
  final SharedPreferencesService _service;

  OnboardingSharedPreferImpl(this._service);

  @override
  Future<bool> getOnboardingStatus() async {
    return await _service.getBool(AppPrefsKeys.hasConpletedOnboarding) ?? false;
  }

  @override
  Future<void> setOnboardingStatus(bool isOnboarded) async {
    await _service.saveBool(AppPrefsKeys.hasConpletedOnboarding, isOnboarded);
  }
}
