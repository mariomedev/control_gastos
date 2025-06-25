import 'package:formz/formz.dart';

enum UserNameInputError { empty, lenght }

class UserNameInput extends FormzInput<String, UserNameInputError> {
  const UserNameInput.pure() : super.pure('');

  const UserNameInput.dirty({String value = ''}) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == UserNameInputError.empty) return 'User name is required';
    if (displayError == UserNameInputError.lenght) return 'User name must be at least 3 characters long and no more than 20 characters';

    return null;
  }

  @override
  UserNameInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return UserNameInputError.empty;
    if (value.length < 3 || value.length > 20) return UserNameInputError.lenght;
    return null;
  }
}
