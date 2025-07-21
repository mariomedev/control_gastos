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
      return 'User password is required';
    }
    if (displayError == PasswordInputError.lenght) {
      return 'User password must be at least 8 characters long and no more than 20 characters';
    }
    if (displayError == PasswordInputError.format) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one number or special character';
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
