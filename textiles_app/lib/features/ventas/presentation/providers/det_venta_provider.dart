import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';

class DetalleVentaNotifier extends StateNotifier<DetalleVentaState> {
  final DetalleVentasRepository detalleVentasRepository;

  DetalleVentaNotifier({required this.detalleVentasRepository})
      : super(DetalleVentaState()) {
    cargarDetalleVenta();
  }

  DetalleVenta nuevoDetalleVenta() {
    return DetalleVenta(
      idtelas: 0,
      cantidad: 0,
      precio: 0,
    );
  }

  Future<void> cargarDetalleVenta() async {
    state = state.copyWith(
      isLoading: false,
      detalleVenta: nuevoDetalleVenta(),
    );    
  }
}

class DetalleVentaState {
  final bool isLoading;
  final DetalleVenta? detalleVenta;

  DetalleVentaState({
    this.isLoading = true,
    this.detalleVenta,
  });

  DetalleVentaState copyWith({
    bool? isLoading,
    DetalleVenta? detalleVenta,
  }) =>
      DetalleVentaState(
        isLoading: isLoading ?? this.isLoading,
        detalleVenta: detalleVenta ?? this.detalleVenta,
      );
}
