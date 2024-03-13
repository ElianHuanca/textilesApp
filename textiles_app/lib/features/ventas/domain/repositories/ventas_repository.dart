import '../entities/venta.dart';


abstract class VentasRepository {

  Future<List<Venta>> getVentas(int idsucursales);
  Future<Venta> getVenta(int id);
  Future<Venta> createVentaAhora(int idsucursales);
}

