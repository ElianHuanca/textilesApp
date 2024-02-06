import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/ventas/domain/domain.dart';
import '../mappers/venta_mapper.dart';


class VentasDatasourceImpl extends VentasDatasource {

  late final Dio dio;
  final String accessToken;

  VentasDatasourceImpl({
    required this.accessToken
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      /* headers: {
        'Authorization': 'Bearer $accessToken'
      } */
    )
  );
  
  @override
  Future<Venta> createUpdateVenta(Map<String, dynamic> VentaLike) {
    // TODO: implement createUpdateVenta
    throw UnimplementedError();
  }
  
  @override
  Future<Venta> getVentaById(String id) {
    // TODO: implement getVentaById
    throw UnimplementedError();
  }
  
  @override
  Future<List<Venta>> getVentasByPage({int limit = 10, int offset = 0})async {
    final response = await dio.get<List>('/ventas');
    final List<Venta> ventas = [];
    for (final venta in response.data ?? [] ) {
      ventas.add(  VentaMapper.jsonToEntity(venta)  );
    }

    return ventas;
  }
  
  @override
  Future<List<Venta>> searchVentaByTerm(String term) {
    // TODO: implement searchVentaByTerm
    throw UnimplementedError();
  }


  

}