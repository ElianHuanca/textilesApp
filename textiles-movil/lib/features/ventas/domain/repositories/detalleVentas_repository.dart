import 'package:teslo_shop/features/ventas/domain/domain.dart';


abstract class DetalleVentasRepository {
  Future<List<DetalleVenta>> getDetalleVenta( int idVenta );
}

