import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import 'package:textiles_app/features/ventas/infrastructure/infrastructure.dart';


final detalleVentasRepositoryProvider = Provider<DetalleVentasRepository>((ref) {  
  
  final detalleVentasRepository = DetalleVentasRepositoryImpl(
    DetalleVentasDatasourceImpl()
  );

  return detalleVentasRepository;
});