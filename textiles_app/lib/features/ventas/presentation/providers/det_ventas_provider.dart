import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final detalleVentasProvider =
    StateNotifierProvider<DetalleVentasNotifier, DetalleVentasState>((ref) {
  final detalleVentasRepository = ref.watch(detalleVentasRepositoryProvider);
  return DetalleVentasNotifier(
      detalleVentasRepository: detalleVentasRepository,
      idVentas: ref.watch(ventaProvider).venta?.id ?? 0);
});

class DetalleVentasNotifier extends StateNotifier<DetalleVentasState> {
  final DetalleVentasRepository detalleVentasRepository;
  final int idVentas;

  DetalleVentasNotifier(
      {required this.idVentas, required this.detalleVentasRepository})
      : super(DetalleVentasState()) {
    getDetVenta(idVentas);
  }

  Future getDetVenta(int idVenta) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final detalleVentas =
        await detalleVentasRepository.getDetalleVenta(idVenta);

    if (detalleVentas.isEmpty) {
      state = state.copyWith(isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: false, detalleVentas: detalleVentas);
  }

  Future<bool> createDetVenta(
      List<Map<String, dynamic>> detalleVentasLike) async {
    try {
      final result =
          await detalleVentasRepository.createDetalleVenta(detalleVentasLike);
      state = state.copyWith(detalleVentas: [...state.detalleVentas,...result]);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class DetalleVentasState {
  final bool isLoading;
  final List<DetalleVenta> detalleVentas;

  DetalleVentasState({this.isLoading = false, this.detalleVentas = const []});

  DetalleVentasState copyWith({
    bool? isLoading,
    List<DetalleVenta>? detalleVentas,
  }) =>
      DetalleVentasState(
        isLoading: isLoading ?? this.isLoading,
        detalleVentas: detalleVentas ?? this.detalleVentas,
      );
}
