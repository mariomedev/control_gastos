import 'package:dart_either/dart_either.dart';
import 'package:supabase/supabase.dart';

import '../domain.dart';

abstract class AuthRepository {
  Future<Either<User, ErrorItem>> signIn(String email, String password);
  Future<Either<User, ErrorItem>> signUp(String email, String password);
}
