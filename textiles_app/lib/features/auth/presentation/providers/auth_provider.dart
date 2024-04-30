import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/auth/domain/domain.dart';
import 'package:textiles_app/features/auth/infrastructure/infrastructure.dart';
import 'package:textiles_app/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:textiles_app/features/shared/infrastructure/services/key_value_storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
      authRepository: authRepository,
      keyValueStorageService: keyValueStorageService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(AuthState(
    //usuario: Usuario(id: 0, nombre: '', correo: '', token: ''),
  )) {
    checkAuthStatus();
  }

  Usuario newEmptyUsuario() {
    return Usuario(
      id: 0,
      nombre: '',
      correo: '',
      token: '',      
    );
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final usuario = await authRepository.login(email, password);
      _setLoggedUser(usuario);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  Future<void> updateUser(String email, String password, String nombre) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final usuario =
          await authRepository.updateUsuario(email, password, nombre);
      _setLoggedUser(usuario);
    } on CustomError catch (e) {
      throw (e.message);
    } catch (e) {
      //logout('Error no controlado');
      throw ('Error no controlado');
    }
  }

  void registerUser(String email, String password) async {}

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');
    if (token == null) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser(Usuario usuario) async {
    await keyValueStorageService.setKeyValue('token', usuario.token);

    state = state.copyWith(
      usuario: usuario,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageService.removeKey('token');

    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        usuario: null,
        errorMessage: errorMessage);
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final Usuario? usuario;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.usuario,
      this.errorMessage = ''});

  AuthState copyWith({
    AuthStatus? authStatus,
    Usuario? usuario,
    String? errorMessage,
  }) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          usuario: usuario ?? this.usuario,
          errorMessage: errorMessage ?? this.errorMessage);
}
