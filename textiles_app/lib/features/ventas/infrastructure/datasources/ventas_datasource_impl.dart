import 'package:dio/dio.dart';
import 'package:textiles_app/config/config.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import 'package:textiles_app/features/ventas/infrastructure/infrastructure.dart';



class VentasDatasourceImpl extends VentasDatasource {

  late final Dio dio;

  VentasDatasourceImpl() : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,      
    )
  );
  
  @override
  Future<List<Venta>> getVentas(int idsucursales)async {
    final response = await dio.get<List>('/ventas/$idsucursales');
    final List<Venta> ventas = [];
    for (final venta in response.data ?? [] ) {
      ventas.add(  VentaMapper.jsonToEntity(venta)  );
    }

    return ventas;
  }  
}