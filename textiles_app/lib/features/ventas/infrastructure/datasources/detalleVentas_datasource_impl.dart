import 'package:dio/dio.dart';
import 'package:textiles_app/config/config.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import 'package:textiles_app/features/ventas/infrastructure/mappers/detalleVenta_mapper.dart';


class DetalleVentasDatasourceImpl extends DetalleVentasDatasource {

  late final Dio dio;
  //final String accessToken;

  DetalleVentasDatasourceImpl(
    //required this.accessToken
  ) : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      /* headers: {
        'Authorization': 'Bearer $accessToken'
      } */
    )
  );
  
  @override
  Future<List<DetalleVenta>> getDetalleVenta(int idVenta) async{

    final response = await dio.get<List>('/det_ventas/$idVenta');
    final List<DetalleVenta> detalleVentas = [];
    for(final detalle in response.data ?? []){
      detalleVentas.add(DetalleVentaMapper.jsonToEntity(detalle));
    }
    return detalleVentas;
  }
  
  @override
  Future<List<DetalleVenta>> createDetalleVenta(List<Map<String, dynamic>> detalleVentasLike) async{
    try {
      final response = await dio.post<List>('/det_ventas', data: detalleVentasLike);
      final detalleVentas = response.data?.map((detalle) => DetalleVentaMapper.jsonToEntity(detalle)).toList();
      return detalleVentas?.cast<DetalleVenta>() ?? [];
    } catch (e) {
      throw Exception();
    }
  }
  
}