import 'package:dart_either/dart_either.dart';
import 'package:supabase/supabase.dart';

import '../../domain/domain.dart';

class AuthSupabaseImpl extends AuthDataSource {
  @override
  Future<Either<User, ErrorItem>> signUp(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<Either<User, ErrorItem>> signIn(String email, String password) {
    throw UnimplementedError();
  }
}
