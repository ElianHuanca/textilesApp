
import 'package:textiles_app/features/auth/domain/domain.dart';

import '../infrastructure.dart';


class AuthRepositoryImpl extends AuthRepository {

  final AuthDataSource dataSource;

  AuthRepositoryImpl({
    AuthDataSource? dataSource
  }) : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<Usuario> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<Usuario> login(String correo, String password) {
    return dataSource.login(correo, password);
  }

  @override
  Future<Usuario> register(String correo, String password, String nombre) {
    return dataSource.register(correo, password, nombre);
  }
  
  @override
  Future<bool> updateUsuario(String correo, String password, String nombre) {
    return dataSource.updateUsuario(correo, password, nombre);
  }

}