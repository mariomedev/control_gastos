import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';

part 'register_form_event.dart';
part 'register_form_state.dart';

class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  final AuthRepository repository;

  RegisterFormBloc({required this.repository})
      : super(const RegisterFormState()) {
    on<RegisterNameChanged>(_onNameChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterFormSubmitted>(_onFormSubmitted);
  }

  Future<void> _onNameChanged(
    RegisterNameChanged event,
    Emitter<RegisterFormState> emit,
  ) async {
    final newName = UserNameInput.dirty(value: event.name);
    emit(state.copyWith(
      userNameInput: newName,
      isValid: Formz.validate([
        newName,
        state.emailInput,
        state.passwordInput,
        state.confirmPasswordInput,
      ]),
    ));
  }

  Future<void> _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterFormState> emit,
  ) async {
    final newEmail = EmailInput.dirty(value: event.email);
    emit(state.copyWith(
      emailInput: newEmail,
      isValid: Formz.validate([
        newEmail,
        state.userNameInput,
        state.passwordInput,
        state.confirmPasswordInput,
      ]),
    ));
  }

  Future<void> _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterFormState> emit,
  ) async {
    final newPassword = PasswordInput.dirty(value: event.password);
    emit(state.copyWith(
      passwordInput: newPassword,
      isValid: Formz.validate([
        newPassword,
        state.userNameInput,
        state.emailInput,
        state.confirmPasswordInput,
      ]),
    ));
  }

  Future<void> _onConfirmPasswordChanged(
    RegisterConfirmPasswordChanged event,
    Emitter<RegisterFormState> emit,
  ) async {
    final newConfirmPassword = ConfirmPasswordInput.dirty(
      value: event.confirmPassword,
      password: state.passwordInput,
    );
    emit(state.copyWith(
      confirmPasswordInput: newConfirmPassword,
      isValid: Formz.validate([
        newConfirmPassword,
        state.userNameInput,
        state.emailInput,
        state.passwordInput,
      ]),
    ));
  }

  Future<void> _onFormSubmitted(
    RegisterFormSubmitted event,
    Emitter<RegisterFormState> emit,
  ) async {
    final newNameInput = UserNameInput.dirty(value: state.userNameInput.value);
    final newEmailInput = EmailInput.dirty(value: state.emailInput.value);
    final newPasswordInput =
        PasswordInput.dirty(value: state.passwordInput.value);
    final newConfirmPasswordInput = ConfirmPasswordInput.dirty(
      password: state.passwordInput,
      value: state.confirmPasswordInput.value,
    );

    emit(state.copyWith(
      isPosted: true,
      userNameInput: newNameInput,
      emailInput: newEmailInput,
      passwordInput: newPasswordInput,
      confirmPasswordInput: newConfirmPasswordInput,
      isValid: Formz.validate([
        newNameInput,
        newEmailInput,
        newPasswordInput,
        newConfirmPasswordInput,
      ]),
    ));

    if (!state.isValid) return;

    emit(state.copyWith(isPosting: true));

    final result = await SignUp(repository).call(
      state.emailInput.value,
      state.passwordInput.value,
    );

    result.fold(
      ifLeft: (error) {
        emit(state.copyWith(isPosting: false, errorMessage: error.message));
      },
      ifRight: (user) {
        emit(state.copyWith(isPosting: false));
      },
    );
  }
}
