
import '../entities/usuario.dart';

abstract class AuthRepository {

  Future<Usuario> login( String correo, String password );
  Future<Usuario> register( String correo, String password, String nombre );
  Future<Usuario> checkAuthStatus( String token );
  Future<Usuario> updateUsuario( int id,String correo, String password, String nombre );
}

