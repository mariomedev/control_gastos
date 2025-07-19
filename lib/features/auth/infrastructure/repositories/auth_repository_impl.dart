import 'package:dart_either/dart_either.dart';
import 'package:supabase/supabase.dart';

import '../../domain/domain.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;
  AuthRepositoryImpl({required this.authDataSource});
  @override
  Future<Either<User, ErrorItem>> signUp(String email, String password) {
    return authDataSource.signUp(email, password);
  }

  @override
  Future<Either<User, ErrorItem>> signIn(String email, String password) {
    return authDataSource.signIn(email, password);
  }
}
