part of 'register_form_bloc.dart';

abstract class RegisterFormEvent extends Equatable {
  const RegisterFormEvent();

  @override
  List<Object> get props => [];
}

class RegisterNameChanged extends RegisterFormEvent {
  final String name;

  const RegisterNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class RegisterEmailChanged extends RegisterFormEvent {
  final String email;

  const RegisterEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends RegisterFormEvent {
  final String password;

  const RegisterPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class RegisterConfirmPasswordChanged extends RegisterFormEvent {
  final String confirmPassword;

  const RegisterConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class RegisterFormSubmitted extends RegisterFormEvent {
  const RegisterFormSubmitted();
}
