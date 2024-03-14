// ignore_for_file: file_names

import 'package:textiles_app/features/ventas/domain/domain.dart';


abstract class DetalleVentasRepository {
  Future<List<DetalleVenta>> getDetalleVenta( int idVenta );
  Future<void> createDetalleVenta( List<Map<String,dynamic>> detalleVentasLike ,int idventas);
}

