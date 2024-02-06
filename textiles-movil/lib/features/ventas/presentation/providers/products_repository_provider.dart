import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';

import 'package:teslo_shop/features/ventas/domain/domain.dart';
import 'package:teslo_shop/features/ventas/infrastructure/infrastructure.dart';


final ventasRepositoryProvider = Provider<VentasRepository>((ref) {
  
  final accessToken = ref.watch( authProvider ).user?.token ?? '';
  
  final productsRepository = VentasRepositoryImpl(
    VentasDatasourceImpl(accessToken: accessToken )
  );

  return productsRepository;
});

