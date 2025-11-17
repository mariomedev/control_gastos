import 'package:get_it/get_it.dart';

import '../domain/domain.dart';
import '../infrastructure/infrastructure.dart';
import '../presentation/bloc/bloc.dart';
import '../../../core/core.dart';

final locator = GetIt.instance;

Future<void> initAuthInjection() async {
  // ═══════════════════════════════════════════════════════════════════════════
  // DATASOURCES
  // ═══════════════════════════════════════════════════════════════════════════
  locator.registerSingleton<AuthDataSource>(
    AuthSupabaseImpl(),
  );

  locator.registerSingleton<OnboardingDataSource>(
    OnboardingSharedPreferImpl(locator<SharedPreferencesService>()),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // REPOSITORIES
  // ═══════════════════════════════════════════════════════════════════════════
  locator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      dataSource: locator<AuthDataSource>(),
    ),
  );

  locator.registerSingleton<OnboardingRepository>(
    OnboardingRepositoryImpl(
      locator<OnboardingDataSource>(),
    ),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // USECASES
  // ═══════════════════════════════════════════════════════════════════════════
  locator.registerSingleton<SignIn>(
    SignIn(locator<AuthRepository>()),
  );

  locator.registerSingleton<SignUp>(
    SignUp(locator<AuthRepository>()),
  );

  locator.registerSingleton<GetHasCompletedOnboarding>(
    GetHasCompletedOnboarding(locator<OnboardingRepository>()),
  );

  locator.registerSingleton<SetHasCompletedOnboarding>(
    SetHasCompletedOnboarding(locator<OnboardingRepository>()),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // BLOCS
  // ═══════════════════════════════════════════════════════════════════════════
  locator.registerSingleton<LoginFormBloc>(
    LoginFormBloc(
      repository: locator<AuthRepository>(),
    ),
  );

  locator.registerSingleton<RegisterFormBloc>(
    RegisterFormBloc(
      repository: locator<AuthRepository>(),
    ),
  );

  locator.registerSingleton<OnboardingBloc>(
    OnboardingBloc(
      repository: locator<OnboardingRepository>(),
    ),
  );
}
