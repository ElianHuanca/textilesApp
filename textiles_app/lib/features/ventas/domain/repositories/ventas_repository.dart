import '../entities/venta.dart';


abstract class VentasRepository {

  Future<List<Venta>> getVentas(int idsucursales);

}

