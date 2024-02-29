

import 'package:textiles_app/features/auth/domain/entities/usuario.dart';

abstract class AuthDataSource {

  Future<Usuario> login( String correo, String password );
  Future<Usuario> register( String correo, String password, String nombre );
  Future<Usuario> checkAuthStatus( String token );

}

