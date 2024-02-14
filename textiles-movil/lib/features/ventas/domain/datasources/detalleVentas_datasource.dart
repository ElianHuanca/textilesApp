import 'package:teslo_shop/features/ventas/domain/domain.dart';


abstract class DetalleVentasDatasource {
  Future<List<DetalleVenta>> getDetalleVenta( int idVenta );
}

