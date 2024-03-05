import '../../domain/domain.dart';

class SucursalesRepositoryImpl implements SucursalesRepository {
  final SucursalesDatasource datasource;

  SucursalesRepositoryImpl(this.datasource);

  @override
  Future<List<Sucursal>> getSucursales(int idusuarios) {
    return datasource.getSucursales(idusuarios);
  }
  
  @override
  Future<Sucursal> createUpdateSucursal(Map<String, dynamic> sucursalLike) {
    return datasource.createUpdateSucursal(sucursalLike);
  }
  
  @override
  Future<void> deleteSucursal(int id) {
    return datasource.deleteSucursal(id);
  }
}
