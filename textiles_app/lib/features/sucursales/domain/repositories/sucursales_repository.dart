import '../domain.dart';

abstract class SucursalesRepository {
  Future<List<Sucursal>> getSucursales(int idusuarios);
  Future<Sucursal> createUpdateSucursal(Map<String, dynamic> sucursalLike,int idusuarios);
  Future<void> deleteSucursal(int id);
}
