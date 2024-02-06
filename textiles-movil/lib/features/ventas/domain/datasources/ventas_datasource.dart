import '../entities/venta.dart';


abstract class VentasDatasource {

  Future<List<Venta>> getVentasByPage({ int limit = 10, int offset = 0 });
  Future<Venta> getVentaById(String id);

  Future<List<Venta>> searchVentaByTerm( String term );
  
  Future<Venta> createUpdateVenta( Map<String,dynamic> VentaLike );


}

