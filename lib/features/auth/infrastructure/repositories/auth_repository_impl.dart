import 'package:dart_either/dart_either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show User;

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;
  AuthRepositoryImpl({required this.authDataSource});
  @override
  Future<Either<ErrorItem, User>> signUp(String email, String password) {
    return authDataSource.signUp(email, password);
  }

  @override
  Future<Either<ErrorItem, User>> signIn(String email, String password) {
    return authDataSource.signIn(email, password);
  }
}
