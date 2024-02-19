import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/telas/domain/domain.dart';
import 'package:teslo_shop/features/telas/infrastructure/mappers/tela_mapper.dart';

class TelasDataSourceImpl extends TelasDatasource {
  late final Dio dio;

  TelasDataSourceImpl()
      : dio = Dio(
          BaseOptions(
            baseUrl: Environment.apiUrl,
          ),
        );
  @override
  Future<List<Tela>> getTelas() async {
    final response = await dio.get<List>('/telas');
    final List<Tela> telas = [];
    for(final tela in response.data ?? []){
      telas.add(TelaMapper.jsonToEntity(tela));
    }
    return telas;
  }
}
