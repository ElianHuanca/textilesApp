import '../../domain/domain.dart';

class TelasRepositoryImpl implements TelasRepository {
  final TelasDatasource datasource;

  TelasRepositoryImpl(this.datasource);

  @override
  Future<List<Tela>> getTelas(int idusuarios) {
    return datasource.getTelas(idusuarios);
  }
  
  @override
  Future<Tela> createUpdateTela(Map<String, dynamic> telaLike) {
    return datasource.createUpdateTela(telaLike);
  }
  
  @override
  Future<bool> deleteTela(int id) {
    // TODO: implement deleteTela
    throw UnimplementedError();
  }
}
