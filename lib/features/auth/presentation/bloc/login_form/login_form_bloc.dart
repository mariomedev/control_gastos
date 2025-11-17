import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final AuthRepository repository;

  LoginFormBloc({required this.repository}) : super(const LoginFormState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginFormSubmitted>(_onFormSubmitted);
  }

  Future<void> _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginFormState> emit,
  ) async {
    final newEmail = EmailInput.dirty(value: event.email);
    emit(state.copyWith(
      emailInput: newEmail,
      isValid: Formz.validate([
        newEmail,
        state.passwordInput,
      ]),
    ));
  }

  Future<void> _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginFormState> emit,
  ) async {
    final newPassword = PasswordInput.dirty(value: event.password);
    emit(state.copyWith(
      passwordInput: newPassword,
      isValid: Formz.validate([
        newPassword,
        state.emailInput,
      ]),
    ));
  }

  Future<void> _onFormSubmitted(
    LoginFormSubmitted event,
    Emitter<LoginFormState> emit,
  ) async {
    final newEmailInput = EmailInput.dirty(value: state.emailInput.value);
    final newPasswordInput =
        PasswordInput.dirty(value: state.passwordInput.value);

    emit(state.copyWith(
      isPosted: true,
      emailInput: newEmailInput,
      passwordInput: newPasswordInput,
      isValid: Formz.validate([
        newEmailInput,
        newPasswordInput,
      ]),
    ));

    if (!state.isValid) return;

    emit(state.copyWith(isPosting: true));

    final result = await SignIn(repository).call(
      state.emailInput.value,
      state.passwordInput.value,
    );

    result.fold(
      ifLeft: (error) {
        emit(state.copyWith(isPosting: false, errorMessage: error.message));
      },
      ifRight: (user) {
        emit(state.copyWith(isPosting: false, errorMessage: ''));

        final context = rootNavigatorKey.currentContext;
        if (context != null) {
          GoRouter.of(context).go(RoutePaths.home);
        }
      },
    );
  }
}
