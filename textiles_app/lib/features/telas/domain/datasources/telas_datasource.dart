

import '../domain.dart';

abstract class TelasDatasource {
  Future<List<Tela>> getTelas(int idusuarios);
  Future<Tela> getTela(int id);
  Future<Tela> createTela(Map<String, dynamic> telaLike,int idusuarios);
  Future<bool> updateTela(Map<String, dynamic> telaLike,int id);  
  Future<bool> deleteTela(int id);  
}