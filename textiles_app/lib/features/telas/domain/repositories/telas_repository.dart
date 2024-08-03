

import '../domain.dart';

abstract class TelasRepository {
  Future<List<Tela>> getTelas();
  Future<Tela> getTela(int id);
  Future<Tela> createTela(Map<String, dynamic> telaLike);
  Future<Tela> updateTela(Map<String, dynamic> telaLike,int id);  
  Future<bool> deleteTela(int id);  
}