import 'package:get_it/get_it.dart';
import 'package:control_gastos/core/services/shared_preferences.dart';
import 'package:control_gastos/features/auth/di/auth_injection.dart';
import 'package:control_gastos/features/profile/di/profile_injection.dart';
import 'package:control_gastos/features/accounts/di/accounts_injection.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ═══════════════════════════════════════════════════════════════════════════
  // CORE SERVICES
  // ═══════════════════════════════════════════════════════════════════════════
  getIt.registerSingleton<SharedPreferencesService>(
    SharedPreferencesServiceImpl(),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // FEATURE INJECTIONS
  // ═══════════════════════════════════════════════════════════════════════════
  await initAuthInjection();
  await initAccountsInjection();
  initProfileInjection();
}
