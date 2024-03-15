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
    final response = await dio.get<List>('/det_ventas/$idventas');
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
      final response = await dio.post<List>('/det_ventas/$idventas',data: detalleVentasLike);      
      final List<DetalleVenta> detalleVentas = [];
      for (final detalle in response.data ?? []) {
        detalleVentas.add(DetalleVentaMapper.jsonToEntity(detalle));
      }
      return detalleVentas;
    }catch (e) {
      throw Exception();
    }
  }
}
