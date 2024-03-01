import '../entities/venta.dart';


abstract class VentasDatasource {

  Future<List<Venta>> getVentas(int idsucursales);

}

