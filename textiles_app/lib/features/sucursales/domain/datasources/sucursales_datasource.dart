

import '../domain.dart';

abstract class SucursalesDatasource {
  Future<List<Sucursal>> getSucursales(int idusuarios);
  Future<Sucursal> createSucursal(Map<String, dynamic> sucursalLike, int idusuarios);
  Future<void> updateSucursal(Map<String, dynamic> sucursalLike,int id);
  Future<void> deleteSucursal(int id);
}