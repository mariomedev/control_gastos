import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';
import 'auth_repository_.dart';

final loginFormProvider =
    StateNotifierProvider<LoginFormNotifier, LoginFormState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginFormNotifier(repository: repository);
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final AuthRepository repository;

  LoginFormNotifier({required this.repository}) : super(LoginFormState());

  onEmailChanged(String value) {
    final newEmail = EmailInput.dirty(value: value);
    state = state.copyWith(
      emailInput: newEmail,
      isValid: Formz.validate(
        [
          newEmail,
          state.passwordInput,
        ],
      ),
    );
  }

  onPasswordChanged(String value) {
    final newPassword = PasswordInput.dirty(value: value);
    state = state.copyWith(
      passwordInput: newPassword,
      isValid: Formz.validate(
        [
          newPassword,
          state.emailInput,
        ],
      ),
    );
  }

  touchEveryField() {
    state = state.copyWith(
      isPosted: true,
      isValid: Formz.validate([
        state.emailInput,
        state.passwordInput,
      ]),
      passwordInput: PasswordInput.dirty(
        value: state.passwordInput.value,
      ),
      emailInput: EmailInput.dirty(
        value: state.emailInput.value,
      ),
    );
  }

  //TODO: Cambiar por eventos para evitar usar context en el provider
  onFormSumit(BuildContext context) async {
    touchEveryField();

    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    final result = await SignIn(repository).call(
      state.emailInput.value,
      state.passwordInput.value,
    );

    state = state.copyWith(isPosting: true);
    result.fold(
      ifLeft: (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(value.message)),
        );
      },
      ifRight: (value) {
        context.go('/home');
      },
    );
    return null;
  }
}

class LoginFormState {
  final bool isPosting;
  final bool isPosted;
  final bool isValid;
  final EmailInput emailInput;
  final PasswordInput passwordInput;

  LoginFormState({
    this.isPosting = false,
    this.isPosted = false,
    this.isValid = false,
    this.emailInput = const EmailInput.pure(),
    this.passwordInput = const PasswordInput.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isPosted,
    bool? isValid,
    UserNameInput? userNameInput,
    EmailInput? emailInput,
    PasswordInput? passwordInput,
    ConfirmPasswordInput? confirmPasswordInput,
  }) =>
      LoginFormState(
        isPosting: isPosting ?? this.isPosting,
        isPosted: isPosted ?? this.isPosted,
        isValid: isValid ?? this.isValid,
        emailInput: emailInput ?? this.emailInput,
        passwordInput: passwordInput ?? this.passwordInput,
      );

  @override
  String toString() {
    return '''
    isPosting: $isPosting
    isPosted: $isPosted
    isValid: $isValid
    emailInput: $emailInput
    passwordInput: $passwordInput
    ''';
  }
}
