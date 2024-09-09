import '../entities/venta.dart';


abstract class VentasRepository {

  Future<List<Venta>> getVentas(int idsucursal);
  Future<Venta> getVenta(int id);
  Future<Venta> createVentaAhora(int idsucursales);
  Future<Venta> actualizarVenta(Map<String,dynamic> ventaLike,int id);
}

