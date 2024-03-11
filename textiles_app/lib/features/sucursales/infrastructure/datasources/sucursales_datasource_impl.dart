import 'package:dio/dio.dart';
import 'package:textiles_app/config/config.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';

class SucursalesDatasourceImpl implements SucursalesDatasource {
  late final Dio dio;

  SucursalesDatasourceImpl()
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
        ));

  @override
  Future<List<Sucursal>> getSucursales(int idusuarios) async {
    final response = await dio.get<List>('/sucursales/$idusuarios');
    final List<Sucursal> sucursales = [];
    for (final sucursal in response.data ?? []) {
      sucursales.add(SucursalMapper.jsonToEntity(sucursal));
    }
    return sucursales;
  }

  @override
  Future<Sucursal> createSucursal(
      Map<String, dynamic> sucursalLike, int idusuarios) async {
    try {
      sucursalLike.remove('id');
      final response =
          await dio.post('/sucursales/$idusuarios', data: sucursalLike);
      final sucursal = SucursalMapper.jsonToEntity(response.data);
      return sucursal;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> updateSucursal(Map<String, dynamic> sucursalLike, int id) async {
    try {
      final response = await dio.put('/sucursales/$id', data: sucursalLike);
      return response.statusCode == 200;
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
}
