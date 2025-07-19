import 'package:dart_either/dart_either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class AuthSupabaseImpl extends AuthDataSource {
  final supabase = Supabase.instance.client;

  @override
  Future<Either<ErrorItem, User>> signUp(String email, String password) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorItem, User>> signIn(String email, String password) async {
    try {
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final User? user = res.user;
      if (user != null) {
        return Either.right(user);
      } else {
        return Either.left(SupabaseErrors.unknown);
      }
    } catch (e) {
      return Either.left(SupabaseErrors.fromException(e));
    }
  }
}
