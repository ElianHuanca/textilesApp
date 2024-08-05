import 'package:dio/dio.dart';
import 'package:textiles_app/config/config.dart';
import 'package:textiles_app/features/auth/domain/domain.dart';
import 'package:textiles_app/features/auth/infrastructure/infrastructure.dart';

class AuthDataSourceImpl extends AuthDataSource {

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  );

  @override
  Future<Usuario> checkAuthStatus(String token) async {
    try {
      final response = await dio.get('/auth/check-status',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          }
        )
      );
      final user = UsuarioMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if( e.response?.statusCode == 401 ){
         throw CustomError('Token incorrecto');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }

  }

  @override
  Future<Usuario> login(String correo, String password) async {
    
    try {      
      final response = await dio.post('/auth', data: {
        'correo': correo,
        'password': password
      });            
      final user = UsuarioMapper.userJsonToEntity(response.data);
      return user;
      
    } on DioException catch (e) {
      if( e.response?.statusCode == 400 ){
         throw CustomError(e.response?.data['message'] ?? 'Credenciales incorrectas' );
      }
      if ( e.type == DioExceptionType.connectionTimeout ){
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }


  }

  @override
  Future<Usuario> register(String correo, String password, String nombre) {    
    throw UnimplementedError();
  }
  
  @override
  Future<Usuario> updateUsuario(int id,String correo, String password, String nombre) async {
    try {
      final response = await dio.put('/usuarios/$id', data: {        
        'nombre': nombre,
        'correo': correo,
        'password': password
      });            
      final user = UsuarioMapper.userJsonToEntity(response.data);
      return user;      
    } on DioException catch (e) {
      if( e.response?.statusCode == 400 ){
         throw CustomError(e.response?.data['message'] ?? 'Credenciales incorrectas' );
      }
      if ( e.type == DioExceptionType.connectionTimeout ){
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
  
}
