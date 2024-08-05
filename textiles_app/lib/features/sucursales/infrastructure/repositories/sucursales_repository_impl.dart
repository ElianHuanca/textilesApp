import '../../domain/domain.dart';

class SucursalesRepositoryImpl implements SucursalesRepository {
  final SucursalesDatasource datasource;

  SucursalesRepositoryImpl(this.datasource);

  @override
  Future<List<Sucursal>> getSucursales() {
    return datasource.getSucursales();
  }
  
  @override
  Future<Sucursal> createSucursal(Map<String, dynamic> sucursalLike) {
    return datasource.createSucursal(sucursalLike);
  }

  @override
  Future<Sucursal> updateSucursal(Map<String, dynamic> sucursalLike, int id) {
    return datasource.updateSucursal(sucursalLike, id);
  }
  
  @override
  Future<bool> deleteSucursal(int id) {
    return datasource.deleteSucursal(id);
  }
  
  @override
  Future<Sucursal> getSucursal(int id) {
    return datasource.getSucursal(id);
  }
}
