

import '../../domain/domain.dart';

class SucursalMapper {
  static jsonToEntity(Map<String, dynamic> json)=> Sucursal(
    id: json['id'] ,
    nombre: json['nombre'] ,
  );
}