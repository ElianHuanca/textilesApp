

import 'package:teslo_shop/features/telas/domain/entities/tela.dart';

abstract class TelasRepository {
  Future<List<Tela>> getTelas();
}