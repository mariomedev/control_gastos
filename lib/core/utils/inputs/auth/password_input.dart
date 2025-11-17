import 'package:formz/formz.dart';

enum PasswordInputError { empty, lenght, format }

class PasswordInput extends FormzInput<String, PasswordInputError> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  const PasswordInput.pure() : super.pure('');

  const PasswordInput.dirty({String value = ''}) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PasswordInputError.empty) {
      return 'La contraseña es requerida';
    }
    if (displayError == PasswordInputError.lenght) {
      return 'La contraseña debe tener entre 8 y 20 caracteres';
    }
    if (displayError == PasswordInputError.format) {
      return 'La contraseña debe contener al menos una mayúscula, una minúscula y un número o carácter especial';
    }

    return null;
  }

  @override
  PasswordInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordInputError.empty;
    if (value.length < 8 || value.length > 20) return PasswordInputError.lenght;
    if (!passwordRegExp.hasMatch(value)) return PasswordInputError.format;
    return null;
  }
}
