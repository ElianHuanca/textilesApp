// ignore_for_file: file_names

import '../../domain/domain.dart';


abstract class DetalleVentasDatasource {
  Future<List<DetalleVenta>> getDetalleVenta( int idventas );
  Future<void> createDetalleVenta( List<Map<String,dynamic>> detalleVentasLike ,int idventas);  
}

