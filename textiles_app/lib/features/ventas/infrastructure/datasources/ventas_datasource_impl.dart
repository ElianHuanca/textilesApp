import 'package:dio/dio.dart';
import 'package:textiles_app/config/config.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import 'package:textiles_app/features/ventas/infrastructure/infrastructure.dart';

class VentasDatasourceImpl extends VentasDatasource {
  late final Dio dio;

  VentasDatasourceImpl()
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
        ));

  @override
  Future<List<Venta>> getVentas(int idsucursales) async {
    final response = await dio.get<List>('/ventas/$idsucursales');
    print('response.data: ${response.data}');
    final List<Venta> ventas = [];
    //if (response.data == null) return ventas;
    for (final venta in response.data ?? []) {
      ventas.add(VentaMapper.jsonToEntity(venta));
    }
    return ventas;
  }

  @override
  Future<Venta> createVentaAhora(int idsucursales) async {
    try {
      final response = await dio.post('/ventas/$idsucursales');
      print(response.data);
      return VentaMapper.jsonToEntity(response.data);
    } catch (e) {
      throw Exception('Error al crear venta: $e');
    }
  }
}
