import 'package:textiles_app/features/ventas/domain/domain.dart';


class DetalleVentaMapper {


  static jsonToEntity( Map<String, dynamic> json ) => DetalleVenta(
    id: json['id'], 
    nombre: json['nombre'],
    cantidad: double.parse(json['cantidad'].toString()),
    precio: double.parse( json['precio'].toString() ),
    total: double.parse( json['total'].toString() ), 
    idtelas: json['idtelas']
  );
}
