
// ignore_for_file: non_constant_identifier_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/ventas/domain/domain.dart';
import 'package:teslo_shop/features/ventas/infrastructure/infrastructure.dart';


final detalleVentasRepositoryProvider = Provider<DetalleVentasRepository>((ref) {
  
  //final accessToken = ref.watch( authProvider ).user?.token ?? '';
  
  final detalleVentasRepository = DetalleVentasRepositoryImpl(
    //VentasDatasourceImpl(accessToken: accessToken )
    DetalleVentasDatasourceImpl()
  );

  return detalleVentasRepository;
});