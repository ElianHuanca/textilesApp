// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:textiles_app/config/config.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import 'package:textiles_app/features/ventas/infrastructure/mappers/detalleVenta_mapper.dart';

class DetalleVentasDatasourceImpl extends DetalleVentasDatasource {
  late final Dio dio;

  DetalleVentasDatasourceImpl()
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
        ));

  @override
  Future<List<DetalleVenta>> getDetalleVenta(int idventas) async {
    final response = await dio.get('/det_ventas/$idventas');
    final List<DetalleVenta> detalleVentas = [];
    for (final detalle in response.data ?? []) {
      detalleVentas.add(DetalleVentaMapper.jsonToEntity(detalle));
    }
    return detalleVentas;
  }

  @override
  Future<List<DetalleVenta>> createDetalleVenta(
      List<Map<String, dynamic>> detalleVentasLike, int idventas) async {
    try {
      final ventas = await dio.post('/det_ventas/$idventas',
          data: detalleVentasLike,
          options: Options(headers: {'Content-Type': 'application/json'}));
      final List<DetalleVenta> detalleVentas = [];
      for (final detalle in ventas.data ?? []) {
        detalleVentas.add(DetalleVentaMapper.jsonToEntity(detalle));
      }
      return detalleVentas;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  @override
  Future<DetalleVenta> deleteDetalleVenta(int id) async {
    try {
      final response = await dio.delete('/det_ventas/$id');
      return DetalleVentaMapper.jsonToEntity(response.data);
    } catch (e) {
      throw Exception();
    }
  }
}
