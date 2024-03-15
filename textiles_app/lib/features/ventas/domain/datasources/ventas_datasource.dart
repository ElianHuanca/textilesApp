import '../entities/venta.dart';


abstract class VentasDatasource {
  Future<List<Venta>> getVentas(int idsucursales);
  Future<Venta> createVentaAhora(int idsucursales);
  Future<bool> updateVenta(Map<String, dynamic> venta, int id);
}

