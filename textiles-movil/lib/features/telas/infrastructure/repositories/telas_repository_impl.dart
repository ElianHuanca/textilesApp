

import 'package:teslo_shop/features/telas/domain/domain.dart';

class TelasRepositoryImpl implements TelasRepository {
  final TelasDatasource dataSource;

  TelasRepositoryImpl(this.dataSource);

  @override
  Future<List<Tela>> getTelas() {
    return dataSource.getTelas();
  }
}