part of 'login_form_bloc.dart';

class LoginFormState extends Equatable {
  final EmailInput emailInput;
  final PasswordInput passwordInput;
  final String errorMessage;
  final bool isValid;
  final bool isPosting;
  final bool isPosted;

  const LoginFormState({
    this.emailInput = const EmailInput.pure(),
    this.passwordInput = const PasswordInput.pure(),
    this.errorMessage = '',
    this.isValid = false,
    this.isPosting = false,
    this.isPosted = false,
  });

  LoginFormState copyWith({
    EmailInput? emailInput,
    PasswordInput? passwordInput,
    String? errorMessage,
    bool? isValid,
    bool? isPosting,
    bool? isPosted,
  }) {
    return LoginFormState(
      emailInput: emailInput ?? this.emailInput,
      passwordInput: passwordInput ?? this.passwordInput,
      errorMessage: errorMessage ?? this.errorMessage,
      isValid: isValid ?? this.isValid,
      isPosting: isPosting ?? this.isPosting,
      isPosted: isPosted ?? this.isPosted,
    );
  }

  @override
  List<Object> get props =>
      [emailInput, passwordInput, errorMessage, isValid, isPosting, isPosted];
}
