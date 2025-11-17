part of 'login_form_bloc.dart';

abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginFormEvent {
  final String email;

  const LoginEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginFormEvent {
  final String password;

  const LoginPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class LoginFormSubmitted extends LoginFormEvent {
  const LoginFormSubmitted();
}
