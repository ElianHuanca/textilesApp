
import '../../domain/domain.dart';
import '../../../database/database_helper.dart';
import '../infrastructure.dart';

class SucursalesDatasourceImpl implements SucursalesDatasource {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
  @override
  Future<List<Sucursal>> getSucursales() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> response = await db.query('sucursales');
    final List<Sucursal> sucursales = [];
    for (final sucursal in response){
      sucursales.add(SucursalMapper.jsonToEntity(sucursal));
    }
    return sucursales;
  }

  @override
  Future<Sucursal> createSucursal(Map<String, dynamic> sucursalLike) async {
    final db = await _databaseHelper.database;
    int id = await db.insert('sucursales', sucursalLike);
    return Sucursal(
      id: id,
      nombre: sucursalLike['nombre'],      
    );
  }
  
  @override
  Future<bool> deleteSucursal(int id) {
    // TODO: implement deleteSucursal
    throw UnimplementedError();
  }
  
  @override
  Future<Sucursal> getSucursal(int id) {
    // TODO: implement getSucursal
    throw UnimplementedError();
  }
  
  @override
  Future<Sucursal> updateSucursal(Map<String, dynamic> sucursalLike, int id) {
    // TODO: implement updateSucursal
    throw UnimplementedError();
  }
}


/* import 'package:dio/dio.dart';
import 'package:textiles_app/config/config.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';

class SucursalesDatasourceImpl implements SucursalesDatasource {
  late final Dio dio;
  final int idusuario;
  SucursalesDatasourceImpl({required this.idusuario})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
        ));

  @override
  Future<List<Sucursal>> getSucursales() async {
    final response = await dio.get<List>('/sucursales/$idusuario');
    final List<Sucursal> sucursales = [];
    for (final sucursal in response.data ?? []) {
      sucursales.add(SucursalMapper.jsonToEntity(sucursal));
    }
    return sucursales;
  }

  @override
  Future<Sucursal> createSucursal(
      Map<String, dynamic> sucursalLike) async {
    try {
      sucursalLike.remove('id');
      final response = await dio.post('/sucursales/$idusuario', data: sucursalLike);
      final sucursal = SucursalMapper.jsonToEntity(response.data);
      return sucursal;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Sucursal> updateSucursal(Map<String, dynamic> sucursalLike, int id) async {
    try {
      final response = await dio.put('/sucursales/$id', data: sucursalLike);      
      final sucursal = SucursalMapper.jsonToEntity(response.data);
      return sucursal;
    } catch (e) {
      throw Exception();      
    }
  }

  @override
  Future<bool> deleteSucursal(int id) async {
    try {
      final response= await dio.delete('/sucursales/$id');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<Sucursal> getSucursal(int id) async{
    try{
      final response = await dio.get('/sucursales/sucursal/$id');
      final sucursal = SucursalMapper.jsonToEntity(response.data);
      return sucursal;
    }catch(e){
      throw Exception();
    }
  }
} */