import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/sucursales/domain/domain.dart';
import 'package:textiles_app/features/sucursales/infrastructure/infrastructure.dart';


final sucursalesRepositoryProvider = Provider<SucursalesRepository>((ref) {
  final sucursalesRepository = SucursalesRepositoryImpl(
    SucursalesDatasourceImpl()
  );
  return sucursalesRepository;
});
