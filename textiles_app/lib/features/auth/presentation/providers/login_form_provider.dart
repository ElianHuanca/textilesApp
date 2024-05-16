import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:textiles_app/features/auth/domain/domain.dart';
import 'package:textiles_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:textiles_app/features/shared/shared.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;
  final updateUserCallback = ref.watch(authProvider.notifier).updateUser;
  return LoginFormNotifier(
      usuario: ref.watch(authProvider).usuario!,
      loginUserCallback: loginUserCallback,
      updateUserCallback: updateUserCallback);
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallback;
  final Function(int, String, String, String) updateUserCallback;
  LoginFormNotifier(
      {required this.loginUserCallback,
      required this.updateUserCallback,
      required Usuario usuario})
      : super(LoginFormState(
          id: usuario.id,
          email: usuario.correo == ''
              ? const Email.pure()
              : Email.dirty(usuario.correo),
          password: const Password.pure(),
          nombre: usuario.nombre,
        ));

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail, isValid: Formz.validate([newEmail, state.password]));
  }

  void onNombreChange(String value) {
    state = state.copyWith(nombre: value);
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email]));
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    await loginUserCallback(state.email.value, state.password.value);

    state = state.copyWith(isPosting: false);
  }

  onFormUpdate() async {
    _touchEveryField();
    if (!state.isValid) return;
    if (state.nombre == '') return;
    state = state.copyWith(isPosting: true);
    await updateUserCallback(
        state.id!, state.email.value, state.password.value, state.nombre!);
    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    if (state.id != 0 && state.password.value.isEmpty) {
      state = state.copyWith(
          isFormPosted: true, email: email, isValid: Formz.validate([email]));
    } else {
      final password = Password.dirty(state.password.value);
      state = state.copyWith(
          isFormPosted: true,
          email: email,
          password: password,
          isValid: Formz.validate([email, password]));
    }
  }
}

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final int? id;
  final Email email;
  final Password password;
  final String? nombre;

  LoginFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.id,
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.nombre});

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    int? id,
    Email? email,
    Password? password,
    String? nombre,
  }) =>
      LoginFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        nombre: nombre ?? this.nombre,
      );
}
