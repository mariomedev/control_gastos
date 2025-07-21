import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';
import 'auth_repository_.dart';

final registerFormProvider =
    StateNotifierProvider<RegisterFormNotifier, RegisterFormState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterFormNotifier(repository: repository);
});

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final AuthRepository repository;

  RegisterFormNotifier({required this.repository}) : super(RegisterFormState());

  onNameChanged(String value) {
    final newName = UserNameInput.dirty(value: value);
    state = state.copyWith(
      userNameInput: newName,
      isValid: Formz.validate(
        [
          newName,
          state.emailInput,
          state.passwordInput,
          state.confirmPasswordInput,
        ],
      ),
    );
  }

  onEmailChanged(String value) {
    final newEmail = EmailInput.dirty(value: value);
    state = state.copyWith(
      emailInput: newEmail,
      isValid: Formz.validate(
        [
          newEmail,
          state.userNameInput,
          state.passwordInput,
          state.confirmPasswordInput,
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
          state.userNameInput,
          state.emailInput,
          state.confirmPasswordInput,
        ],
      ),
    );
  }

  onConfirmPasswordChanged(String value) {
    final newConfirmPassword = ConfirmPasswordInput.dirty(
      value: value,
      password: state.passwordInput,
    );
    state = state.copyWith(
      confirmPasswordInput: newConfirmPassword,
      isValid: Formz.validate(
        [
          newConfirmPassword,
          state.userNameInput,
          state.emailInput,
          state.passwordInput,
        ],
      ),
    );
  }

  touchEveryField() {
    state = state.copyWith(
      isPosted: true,
      isValid: Formz.validate([
        state.userNameInput,
        state.emailInput,
        state.passwordInput,
        ConfirmPasswordInput.dirty(
          password: state.passwordInput,
          value: state.confirmPasswordInput.value,
        ),
      ]),
      userNameInput: UserNameInput.dirty(
        value: state.userNameInput.value,
      ),
      emailInput: EmailInput.dirty(
        value: state.emailInput.value,
      ),
      passwordInput: PasswordInput.dirty(
        value: state.passwordInput.value,
      ),
      confirmPasswordInput: ConfirmPasswordInput.dirty(
        password: state.passwordInput,
        value: state.confirmPasswordInput.value,
      ),
    );
  }

  //TODO: implemertar sin el context para que sea mas testable

  Future<void> onFormSumit(BuildContext context) async {
    touchEveryField();
    if (!state.isValid) return;

    final result = await SignUp(repository).call(
      state.emailInput.value,
      state.confirmPasswordInput.value,
    );

    result.fold(
      ifLeft: (errorItem) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorItem.message)),
        );
      },
      ifRight: (user) {
        context.go('/home');
      },
    );
  }
}

class RegisterFormState {
  final bool isPosting;
  final bool isPosted;
  final bool isValid;
  final UserNameInput userNameInput;
  final EmailInput emailInput;
  final PasswordInput passwordInput;
  final ConfirmPasswordInput confirmPasswordInput;

  RegisterFormState({
    this.isPosting = false,
    this.isPosted = false,
    this.isValid = false,
    this.userNameInput = const UserNameInput.pure(),
    this.emailInput = const EmailInput.pure(),
    this.passwordInput = const PasswordInput.pure(),
    this.confirmPasswordInput = const ConfirmPasswordInput.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isPosted,
    bool? isValid,
    UserNameInput? userNameInput,
    EmailInput? emailInput,
    PasswordInput? passwordInput,
    ConfirmPasswordInput? confirmPasswordInput,
  }) =>
      RegisterFormState(
        isPosting: isPosting ?? this.isPosting,
        isPosted: isPosted ?? this.isPosted,
        isValid: isValid ?? this.isValid,
        userNameInput: userNameInput ?? this.userNameInput,
        emailInput: emailInput ?? this.emailInput,
        passwordInput: passwordInput ?? this.passwordInput,
        confirmPasswordInput: confirmPasswordInput ?? this.confirmPasswordInput,
      );

  @override
  String toString() {
    return '''
    isPosting: $isPosting
    isPosted: $isPosted
    isValid: $isValid
    userNameInput: $userNameInput
    emailInput: $emailInput
    passwordInput: $passwordInput
    confirmPasswordInput: $confirmPasswordInput
    ''';
  }
}
