import '../../domain/domain.dart';

class SucursalesRepositoryImpl implements SucursalesRepository {
  final SucursalesDatasource datasource;

  SucursalesRepositoryImpl(this.datasource);

  @override
  Future<List<Sucursal>> getSucursales(int idusuarios) {
    return datasource.getSucursales(idusuarios);
  }
  
  @override
  Future<Sucursal> createSucursal(Map<String, dynamic> sucursalLike,int idusuarios) {
    return datasource.createSucursal(sucursalLike, idusuarios);
  }

  @override
  Future<bool> updateSucursal(Map<String, dynamic> sucursalLike, int id) {
    return datasource.updateSucursal(sucursalLike, id);
  }
  
  @override
  Future<bool> deleteSucursal(int id) {
    return datasource.deleteSucursal(id);
  }
  
  
}
