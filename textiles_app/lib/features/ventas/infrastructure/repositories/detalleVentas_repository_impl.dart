import 'package:textiles_app/features/ventas/domain/domain.dart';



class DetalleVentasRepositoryImpl extends DetalleVentasRepository {

  final DetalleVentasDatasource datasource;

  DetalleVentasRepositoryImpl(this.datasource);
  
  @override
  Future<List<DetalleVenta>> getDetalleVenta(int idVenta) {
    return datasource.getDetalleVenta(idVenta);
  }
  
  @override
  Future<List<DetalleVenta>> createDetalleVenta(List<Map<String, dynamic>> detalleVentasLike,int idventas) {
    return datasource.createDetalleVenta(detalleVentasLike, idventas);
  }



}