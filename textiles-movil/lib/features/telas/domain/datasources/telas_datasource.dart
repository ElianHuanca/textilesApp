

import 'package:teslo_shop/features/telas/domain/entities/tela.dart';

abstract class TelasDatasource {
  Future<List<Tela>> getTelas();
}