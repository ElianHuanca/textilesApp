import 'package:textiles_app/features/sucursales/domain/domain.dart';

class SucursalesRepositoryImpl implements SucursalesRepository {
  final SucursalesDatasource datasource;

  SucursalesRepositoryImpl(this.datasource);

  @override
  Future<List<Sucursal>> getSucursales(int idusuarios) {
    return datasource.getSucursales(idusuarios);
  }
}
