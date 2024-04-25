import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:textiles_app/features/auth/domain/entities/usuario.dart';
import 'package:textiles_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:textiles_app/features/shared/shared.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;
  final updateUserCallback = ref.watch(authProvider.notifier).updateUser;
  final userCallback = ref.watch(authProvider).usuario;
  return LoginFormNotifier(
      loginUserCallback: loginUserCallback,
      userCallback: userCallback,
      updateUserCallback:updateUserCallback
      );
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallback;
  final Function(String, String,String) updateUserCallback;
  final Usuario? userCallback;
  LoginFormNotifier({
    required this.loginUserCallback,
    required this.updateUserCallback,
    this.userCallback,
  }) : super(LoginFormState());

  void cargarUsuario() {
    state = state.copyWith(
      email: Email.dirty(userCallback!.correo),
    );
  }

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

    await updateUserCallback(state.email.value, state.password.value,state.nombre!);

    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        isValid: Formz.validate([email, password]));
  }

}

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final String? nombre;

  LoginFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.nombre = ''
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    String? nombre,
  }) =>
      LoginFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
        nombre: nombre ?? this.nombre,
      );
}
