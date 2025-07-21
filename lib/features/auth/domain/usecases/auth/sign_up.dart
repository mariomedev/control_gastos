import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dart_either/dart_either.dart';

import '../../../../../core/core.dart';
import '../../domain.dart';

class SignUp {
  final AuthRepository repository;

  SignUp(this.repository);

  Future<Either<ErrorItem, User>> call(String email, String password) async {
    return await repository.signUp(email, password);
  }
}
