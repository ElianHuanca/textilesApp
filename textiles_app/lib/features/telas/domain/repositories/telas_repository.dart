

import '../domain.dart';

abstract class TelasRepository {
  Future<List<Tela>> getTelas(int idusuarios);
  Future<Tela> createUpdateTela(Map<String, dynamic> telaLike);
  Future<bool> deleteTela(int id);
}