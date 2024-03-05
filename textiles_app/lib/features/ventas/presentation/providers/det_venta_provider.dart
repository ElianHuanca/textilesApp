import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers.dart';
import '../../domain/domain.dart';

final detalleVentaProvider =
    StateNotifierProvider<DetalleVentaNotifier, DetalleVentaState>((ref) {
        final detalleVentasRepository = ref.watch(detalleVentasRepositoryProvider);
        return DetalleVentaNotifier(detalleVentasRepository: detalleVentasRepository);
    });

class DetalleVentaNotifier extends StateNotifier<DetalleVentaState> {
  final DetalleVentasRepository detalleVentasRepository;

  DetalleVentaNotifier({required this.detalleVentasRepository})
      : super(DetalleVentaState()) {
    nuevoDetVenta();
  }

  DetalleVenta newEmptyDetVenta() {
    return DetalleVenta(
      idtelas: 0,
      cantidad: 0,
      precio: 0,
    );
  }

  Future<void> nuevoDetVenta() async {
    state = state.copyWith(
      isLoading: false,
      detalleVenta: newEmptyDetVenta(),
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
