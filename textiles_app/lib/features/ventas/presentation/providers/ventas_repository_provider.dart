import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';


final ventasRepositoryProvider = Provider<VentasRepository>((ref) {

  final ventasRepository = VentasRepositoryImpl(
    VentasDatasourceImpl()
  );

  return ventasRepository;
});

