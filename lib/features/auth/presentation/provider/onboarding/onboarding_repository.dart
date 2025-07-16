import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../../infrastructure/infrastructure.dart';

final onboardingRepository = Provider<OnboardingRepository>((ref) {
  final dataSource = OnboardingSharedPreferImpl(SharedPreferencesServiceImpl());
  return OnboardingRepositoryImpl(dataSource);
});
