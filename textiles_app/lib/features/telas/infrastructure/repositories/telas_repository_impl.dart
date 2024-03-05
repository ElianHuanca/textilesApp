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
  Future<void> deleteTela(int id) {   
    return datasource.deleteTela(id);
  }
}
