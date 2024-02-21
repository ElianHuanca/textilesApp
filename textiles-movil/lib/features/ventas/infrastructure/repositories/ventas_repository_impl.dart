import 'package:teslo_shop/features/ventas/domain/domain.dart';



class VentasRepositoryImpl extends VentasRepository {

  final VentasDatasource datasource;

  VentasRepositoryImpl(this.datasource);


  @override
  Future<Venta> createUpdateVenta(Map<String, dynamic> VentaLike) {
    return datasource.createUpdateVenta(VentaLike);
  }

  @override
  Future<Venta> getVentaById(String id) {
    return datasource.getVentaById(id);
  }

  @override
  Future<List<Venta>> getVentasByPage({int limit = 10, int offset = 0}) {
    return datasource.getVentasByPage( limit: limit, offset: offset );
  }

  @override
  Future<List<Venta>> searchVentaByTerm(String term) {
    return datasource.searchVentaByTerm(term);
  }

}