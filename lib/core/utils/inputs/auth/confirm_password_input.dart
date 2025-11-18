import 'package:control_gastos/core/utils/inputs/auth/password_input.dart';
import 'package:formz/formz.dart';

enum ConfirmPasswordInputError { empty, mismatch }

class ConfirmPasswordInput
    extends FormzInput<String, ConfirmPasswordInputError> {
  final PasswordInput password;

  const ConfirmPasswordInput.pure()
      : password = const PasswordInput.pure(),
        super.pure('');

  const ConfirmPasswordInput.dirty({required this.password, String value = ''})
      : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == ConfirmPasswordInputError.empty) {
      return 'La contraseña es requerida';
    }
    if (displayError == ConfirmPasswordInputError.mismatch) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }

  @override
  ConfirmPasswordInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return ConfirmPasswordInputError.empty;
    }
    if (value != password.value) {
      return ConfirmPasswordInputError.mismatch;
    }

    return null;
  }
}
