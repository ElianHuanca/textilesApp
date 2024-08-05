import '../entities/venta.dart';


abstract class VentasDatasource {
  Future<List<Venta>> getVentas(int idsucursales);
  Future<Venta> getVenta(int id);
  Future<Venta> createVentaAhora(int idsucursales);    
}

