

import '../domain.dart';

abstract class SucursalesDatasource {
  Future<List<Sucursal>> getSucursales();
  Future<Sucursal> getSucursal(int id);
  Future<Sucursal> createSucursal(Map<String, dynamic> sucursalLike);
  Future<bool> updateSucursal(Map<String, dynamic> sucursalLike,int id);
  Future<bool> deleteSucursal(int id);
}