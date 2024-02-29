
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
  Future<Usuario> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<Usuario> register(String email, String password, String fullName) {
    return dataSource.register(email, password, fullName);
  }

}