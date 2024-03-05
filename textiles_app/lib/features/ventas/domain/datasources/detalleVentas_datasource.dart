import '../../domain/domain.dart';


abstract class DetalleVentasDatasource {
  Future<List<DetalleVenta>> getDetalleVenta( int idventas );
  Future<List<DetalleVenta>> createDetalleVenta( List<Map<String,dynamic>> detalleVentasLike );  
}

