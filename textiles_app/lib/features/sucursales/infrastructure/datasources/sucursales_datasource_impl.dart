import 'package:dio/dio.dart';
import 'package:textiles_app/config/config.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';


class SucursalesDatasourceImpl implements SucursalesDatasource {
  late final Dio dio;

  SucursalesDatasourceImpl() : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  );

  @override
  Future<List<Sucursal>> getSucursales(int idusuarios) async{
    final response = await dio.get<List>('/sucursales/$idusuarios');
    final List<Sucursal> sucursales = [];
    for (final sucursal in response.data ?? [] ) {
      sucursales.add(  SucursalMapper.jsonToEntity(sucursal)  );
    }
    return sucursales;
  }
  
  @override
  Future<Sucursal> createUpdateSucursal(Map<String, dynamic> sucursalLike) async{
    try {
      
      final int? sucursalId = sucursalLike['id'];
      final String method = (sucursalId == 0) ? 'POST' : 'PUT';
      final String url = (sucursalId == 0) ? '/sucursales' : '/sucursales/$sucursalId';

      sucursalLike.remove('id');

      final response = await dio.request(
        url,
        data: sucursalLike,
        options: Options(
          method: method
        )
      );

      final sucursal = SucursalMapper .jsonToEntity(response.data);
      return sucursal;

    } catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<void> deleteSucursal(int id) async{    
      try{
        await dio.delete('/sucursales/$id');
      }catch(e){
        throw Exception();
      }
  }
  
}
