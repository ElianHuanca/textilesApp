import 'package:dio/dio.dart';
import 'package:textiles_app/config/config.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import 'package:textiles_app/features/ventas/infrastructure/infrastructure.dart';

class VentasDatasourceImpl extends VentasDatasource {
  late final Dio dio;
  final int idsucursal;
  VentasDatasourceImpl({required this.idsucursal})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
        ));

  @override
  Future<List<Venta>> getVentas() async {
    final response = await dio.get<List>('/ventas/$idsucursal');    
    final List<Venta> ventas = [];    
    for (final venta in response.data ?? []) {
      ventas.add(VentaMapper.jsonToEntity(venta));
    }
    return ventas;
  }

  @override
  Future<Venta> createVentaAhora(int idsucursales) async {
    try {
      final response = await dio.post('/ventas/$idsucursales');  
      return VentaMapper.jsonToEntity(response.data);
    } catch (e) {
      throw Exception('Error al crear venta: $e');
    }
  }
  
  @override
  Future<Venta> getVenta(int id) async{
    try{
      final response = await dio.get('/ventas/venta/$id');
      return VentaMapper.jsonToEntity(response.data);
    }catch(e){
      throw Exception('Error al obtener venta: $e');
    }
  }
  
  @override
  Future<Venta> actualizarVenta(Map<String, dynamic> ventaLike, int id) async{
    try{
      final response = await dio.put('/ventas/$id', data: ventaLike);
      return VentaMapper.jsonToEntity(response.data);
    }catch(e){
      throw Exception('Error al actualizar venta: $e');
    }
  }
}
