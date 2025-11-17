part of 'register_form_bloc.dart';

class RegisterFormState extends Equatable {
  final UserNameInput userNameInput;
  final EmailInput emailInput;
  final PasswordInput passwordInput;
  final ConfirmPasswordInput confirmPasswordInput;
  final String errorMessage;
  final bool isValid;
  final bool isPosting;
  final bool isPosted;

  const RegisterFormState({
    this.userNameInput = const UserNameInput.pure(),
    this.emailInput = const EmailInput.pure(),
    this.passwordInput = const PasswordInput.pure(),
    this.confirmPasswordInput = const ConfirmPasswordInput.pure(),
    this.errorMessage = '',
    this.isValid = false,
    this.isPosting = false,
    this.isPosted = false,
  });

  RegisterFormState copyWith({
    UserNameInput? userNameInput,
    EmailInput? emailInput,
    PasswordInput? passwordInput,
    ConfirmPasswordInput? confirmPasswordInput,
    String? errorMessage,
    bool? isValid,
    bool? isPosting,
    bool? isPosted,
  }) {
    return RegisterFormState(
      userNameInput: userNameInput ?? this.userNameInput,
      emailInput: emailInput ?? this.emailInput,
      passwordInput: passwordInput ?? this.passwordInput,
      confirmPasswordInput: confirmPasswordInput ?? this.confirmPasswordInput,
      errorMessage: errorMessage ?? this.errorMessage,
      isValid: isValid ?? this.isValid,
      isPosting: isPosting ?? this.isPosting,
      isPosted: isPosted ?? this.isPosted,
    );
  }

  @override
  List<Object> get props => [
        userNameInput,
        emailInput,
        passwordInput,
        confirmPasswordInput,
        errorMessage,
        isValid,
        isPosting,
        isPosted,
      ];
}
