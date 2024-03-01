

import 'package:textiles_app/features/sucursales/domain/domain.dart';

abstract class SucursalesDatasource {
  Future<List<Sucursal>> getSucursales(int idusuarios);
  /* Future<void> registrarSucursales(Sucursal sucursal);
  Future<void> eliminarSucursal(Sucursal sucursal);
  Future<void> actualizarSucursal(Sucursal sucursal); */  
}