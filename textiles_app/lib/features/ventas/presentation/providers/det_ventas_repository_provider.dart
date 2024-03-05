import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';


final detalleVentasRepositoryProvider = Provider<DetalleVentasRepository>((ref) {  
  
  final detalleVentasRepository = DetalleVentasRepositoryImpl(
    DetalleVentasDatasourceImpl()
  );

  return detalleVentasRepository;
});