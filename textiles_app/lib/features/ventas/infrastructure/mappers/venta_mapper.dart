import 'package:textiles_app/features/ventas/domain/entities/venta.dart';



class VentaMapper {
  static jsonToEntity( Map<String, dynamic> json ) => Venta(
    id: json['id'], 
    fecha: DateTime.parse( json['fecha']), 
    total: double.parse( json['total'].toString() ), 
    ganancias: double.parse( json['ganancias'].toString() ), 
    idsucursales: json['idsucursales'],
    descuento: double.parse( json['descuento'].toString() )
  );
}
