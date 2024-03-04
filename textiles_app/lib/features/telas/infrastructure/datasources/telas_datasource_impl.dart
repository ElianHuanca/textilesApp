import 'package:dio/dio.dart';
import 'package:textiles_app/config/config.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';


class TelasDatasourceImpl implements TelasDatasource {
  late final Dio dio;

  TelasDatasourceImpl() : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  );

  @override
  Future<List<Tela>> getTelas(int idusuarios) async{
    final response = await dio.get<List>('/telas/$idusuarios');
    final List<Tela> telas = [];
    for (final tela in response.data ?? [] ) {
      telas.add(  TelaMapper.jsonToEntity(tela)  );
    }
    return telas;
  }
  
  @override
  Future<Tela> createUpdateTela(Map<String, dynamic> telaLike) async{
    try {
      
      final int? telaId = telaLike['id'];
      final String method = (telaId == 0) ? 'POST' : 'PUT';
      final String url = (telaId == 0) ? '/telas' : '/telas/$telaId';

      telaLike.remove('id');

      final response = await dio.request(
        url,
        data: telaLike,
        options: Options(
          method: method
        )
      );

      final tela = TelaMapper .jsonToEntity(response.data);
      return tela;

    } catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<bool> deleteTela(int id) {
    // TODO: implement deleteTela
    throw UnimplementedError();
  }
  
}
