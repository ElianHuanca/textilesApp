import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import 'package:textiles_app/features/ventas/infrastructure/infrastructure.dart';


final ventasRepositoryProvider = Provider<VentasRepository>((ref) {
  
  final ventasRepository = VentasRepositoryImpl(
    VentasDatasourceImpl()
  );

  return ventasRepository;
});

