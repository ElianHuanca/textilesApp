// ignore_for_file: file_names

import 'package:textiles_app/features/ventas/domain/domain.dart';


class DetalleVentaMapper {


  static jsonToEntity( Map<String, dynamic> json ) => DetalleVenta(
    id: json['id'], 
    nombre: json['nombre'],
    cantidad: double.parse(json['cantidad'].toString()),
    precio: double.parse( json['precio'].toString() ),
    total: double.parse( json['total'].toString() ), 
    ganancias: double.parse( json['ganancias'].toString() ),
    idtelas: json['idtelas']
  );
}
