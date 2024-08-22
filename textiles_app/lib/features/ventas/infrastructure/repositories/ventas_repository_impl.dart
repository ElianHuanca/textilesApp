import 'package:textiles_app/features/ventas/domain/domain.dart';



class VentasRepositoryImpl extends VentasRepository {

  final VentasDatasource datasource;

  VentasRepositoryImpl(this.datasource);

  @override
  Future<List<Venta>> getVentas() {
    return datasource.getVentas();
  }

  @override
  Future<Venta> createVentaAhora(int idsucursales) {
    return datasource.createVentaAhora(idsucursales);
  }
  
  @override
  Future<Venta> getVenta(int id) {
    return datasource.getVenta(id);
  }
  
  @override
  Future<Venta> actualizarVenta(Map<String, dynamic> ventaLike, int id) {
    return datasource.actualizarVenta(ventaLike, id);
  }  
  
}