import 'package:control_gastos/features/auth/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final AuthDataSource dataSource = AuthSupabaseImpl();
  return AuthRepositoryImpl(dataSource: dataSource);
});
