

import '../domain.dart';

abstract class TelasDatasource {
  Future<List<Tela>> getTelas(int idusuarios);
  Future<Tela> createUpdateTela(Map<String, dynamic> telaLike);
  Future<bool> deleteTela(int id);
}