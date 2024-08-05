import 'package:dio/dio.dart';
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
      final response = await dio.get('/sucursales/$id');
      final sucursal = SucursalMapper.jsonToEntity(response.data);
      return sucursal;
    }catch(e){
      throw Exception();
    }
  }
}
