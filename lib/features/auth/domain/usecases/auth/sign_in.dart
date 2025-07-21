import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dart_either/dart_either.dart';

import '../../../../../core/core.dart';
import '../../domain.dart';

class SignIn {
  final AuthRepository repository;

  SignIn(this.repository);

  Future<Either<ErrorItem, User>> call(String email, String password) async {
    return await repository.signIn(email, password);
  }
}
