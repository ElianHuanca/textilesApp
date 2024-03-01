

import 'package:textiles_app/features/sucursales/domain/entities/sucursal.dart';

class SucursalMapper {
  static jsonToEntity(Map<String, dynamic> json)=> Sucursal(
    id: json['id'] ,
    nombre: json['nombre'] ,
  );
}