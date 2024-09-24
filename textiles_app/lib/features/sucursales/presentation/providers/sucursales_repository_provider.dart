import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:textiles_app/features/sucursales/domain/domain.dart';
import 'package:textiles_app/features/sucursales/infrastructure/infrastructure.dart';


final sucursalesRepositoryProvider = Provider<SucursalesRepository>((ref) {  

  final int idusuario = ref.read(authProvider).usuario!.id;//ref.watch(authProvider).usuario!.id;

  return SucursalesRepositoryImpl(
    SucursalesDatasourceImpl( idusuario:idusuario),
  );
  
});
