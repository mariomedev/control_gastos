import 'package:formz/formz.dart';

enum EmailInputError { empty, format }

class EmailInput extends FormzInput<String, EmailInputError> {
  static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  const EmailInput.pure() : super.pure('');

  const EmailInput.dirty({String value = ''}) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == EmailInputError.empty) {
      return 'El correo electrónico es requerido';
    }
    if (displayError == EmailInputError.format) {
      return 'Formato de correo inválido';
    }

    return null;
  }

  @override
  EmailInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return EmailInputError.empty;
    }
    if (!emailRegExp.hasMatch(value)) {
      return EmailInputError.format;
    }

    return null;
  }
}
