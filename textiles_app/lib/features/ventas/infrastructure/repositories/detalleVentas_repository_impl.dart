// ignore_for_file: file_names

import 'package:textiles_app/features/ventas/domain/domain.dart';



class DetalleVentasRepositoryImpl extends DetalleVentasRepository {

  final DetalleVentasDatasource datasource;

  DetalleVentasRepositoryImpl(this.datasource);
  
  @override
  Future<List<DetalleVenta>> getDetalleVenta(int idVenta) {
    return datasource.getDetalleVenta(idVenta);
  }
  
  @override
  Future<List<DetalleVenta>> createDetalleVenta(List<Map<String, dynamic>> detalleVentasLike,int idventas,double descuento) {
    return datasource.createDetalleVenta(detalleVentasLike, idventas,descuento);
  }
  
  @override
  Future<bool> deleteDetalleVenta(int id) {
    return datasource.deleteDetalleVenta(id);
  }
}