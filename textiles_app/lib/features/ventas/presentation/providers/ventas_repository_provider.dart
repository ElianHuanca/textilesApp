import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/auth/presentation/providers/providers.dart';
import 'package:textiles_app/features/sucursales/presentation/providers/providers.dart';

import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';


final ventasRepositoryProvider = Provider<VentasRepository>((ref) {

  final int idusuario = ref.watch(authProvider).usuario!.id;
  final int idsucursal = ref.read(sucursalProvider(idusuario)).id;

  final ventasRepository = VentasRepositoryImpl(
    VentasDatasourceImpl(idsucursal: idsucursal)
  );

  return ventasRepository;
});

