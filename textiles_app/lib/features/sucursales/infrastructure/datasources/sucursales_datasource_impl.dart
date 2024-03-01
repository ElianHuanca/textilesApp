import 'package:dio/dio.dart';
import 'package:textiles_app/config/config.dart';
import 'package:textiles_app/features/sucursales/domain/domain.dart';
import 'package:textiles_app/features/sucursales/infrastructure/infrastructure.dart';


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
  
}
