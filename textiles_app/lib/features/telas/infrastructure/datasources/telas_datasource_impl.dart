import 'package:dio/dio.dart';
import 'package:textiles_app/config/config.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';

class TelasDatasourceImpl implements TelasDatasource {
  late final Dio dio;
  final int idusuario;
  TelasDatasourceImpl({required this.idusuario})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
        ));

  @override
  Future<List<Tela>> getTelas() async {
    final response = await dio.get<List>('/telas/$idusuario');
    final List<Tela> telas = [];
    for (final tela in response.data ?? []) {
      telas.add(TelaMapper.jsonToEntity(tela));
    }
    return telas;
  }

  @override
  Future<Tela> createTela(Map<String, dynamic> telaLike) async {
    try {
      telaLike.remove('id');
      final response = await dio.post('/telas/$idusuario', data: telaLike);
      final tela = TelaMapper.jsonToEntity(response.data);
      return tela;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Tela> updateTela(Map<String, dynamic> telaLike, int id) async {
    try {
      final response = await dio.put('/telas/$id', data: telaLike);
      final tela = TelaMapper.jsonToEntity(response.data);
      return tela;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> deleteTela(int id) async {
    try {
      final response = await dio.delete('/telas/$id');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<Tela> getTela(int id) async{
    try{
      final response = await dio.get('/telas/$id');
      final tela = TelaMapper.jsonToEntity(response.data);
      return tela;
    }catch(e){
      throw Exception();
    }
  }
}
