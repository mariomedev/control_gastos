import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dart_either/dart_either.dart';

import '../../../../core/core.dart';

abstract class AuthDataSource {
  Future<Either<ErrorItem, User>> signIn(String email, String password);
  Future<Either<ErrorItem, User>> signUp(String email, String password);
}
