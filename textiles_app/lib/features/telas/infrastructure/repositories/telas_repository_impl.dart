import '../../domain/domain.dart';

class TelasRepositoryImpl implements TelasRepository {
  final TelasDatasource datasource;

  TelasRepositoryImpl(this.datasource);

  @override
  Future<List<Tela>> getTelas() {
    return datasource.getTelas();
  }
  
  @override
  Future<Tela> createTela(Map<String, dynamic> telaLike) {
    return datasource.createTela(telaLike);
  }
  
  @override
  Future<Tela> updateTela(Map<String, dynamic> telaLike,int id) {   
    return datasource.updateTela(telaLike,id);
  }

  @override
  Future<bool> deleteTela(int id) {   
    return datasource.deleteTela(id);
  }
  
  @override
  Future<Tela> getTela(int id) {
    return datasource.getTela(id);
  }
}
