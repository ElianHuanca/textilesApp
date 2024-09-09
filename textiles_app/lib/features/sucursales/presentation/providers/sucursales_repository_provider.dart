import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:textiles_app/features/sucursales/domain/domain.dart';
import 'package:textiles_app/features/sucursales/infrastructure/infrastructure.dart';


final sucursalesRepositoryProvider = Provider<SucursalesRepository>((ref) {  

  final idusuario = ref.watch(authProvider).usuario!.id;

  final sucursalesRepository = SucursalesRepositoryImpl(
    SucursalesDatasourceImpl( idusuario:idusuario),
  );
  return sucursalesRepository;
});
