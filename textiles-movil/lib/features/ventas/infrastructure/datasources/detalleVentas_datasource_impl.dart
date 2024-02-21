import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/ventas/domain/domain.dart';
import 'package:teslo_shop/features/ventas/infrastructure/mappers/detalleVenta_mapper.dart';


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

    final response = await dio.get<List>('/ventas/$idVenta');
    final List<DetalleVenta> detalleVentas = [];
    for(final detalle in response.data ?? []){
      detalleVentas.add(DetalleVentaMapper.jsonToEntity(detalle));
    }
    return detalleVentas;
  }
  
}