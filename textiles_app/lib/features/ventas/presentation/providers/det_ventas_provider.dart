import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final detalleVentasProvider = StateNotifierProvider.autoDispose
    .family<DetalleVentasNotifier, DetalleVentasState, int>((ref, idventa) {
  final detalleVentasRepository = ref.watch(detalleVentasRepositoryProvider);
  return DetalleVentasNotifier(
    detalleVentasRepository: detalleVentasRepository,
    idventa:idventa
  );
});

class DetalleVentasNotifier extends StateNotifier<DetalleVentasState> {
  final DetalleVentasRepository detalleVentasRepository;

  DetalleVentasNotifier({
    required this.detalleVentasRepository,
    required int idventa
  }) : super(DetalleVentasState(idventa:idventa)) {
    getDetVenta(idventa);
  }

  Future getDetVenta(int idventa) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final detalleVentas =
        await detalleVentasRepository.getDetalleVenta(idventa);

    if (detalleVentas.isEmpty) {
      state = state.copyWith(isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: false, detalleVentas: detalleVentas);
  }

  Future<bool> createDetVenta(
      List<Map<String, dynamic>> detalleVentasLike, double descuento) async {
    try {
      double total = 0.0;
      double ganancias = 0.0;
      for (var detalle in detalleVentasLike) {
        total += detalle['total'];
        ganancias += detalle['ganancias'];
      }      
      final response = await detalleVentasRepository.createDetalleVenta(
          detalleVentasLike, venta.id, descuento);
      state =
          state.copyWith(detalleVentas: [...response, ...state.detalleVentas]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteDetVenta(int id) async {
    try {
      final response = await detalleVentasRepository.deleteDetalleVenta(id);
      if (response) {
        final Venta venta = getVenta!();
        final detalle =
            state.detalleVentas.firstWhere((detalle) => detalle.id == id);
        venta.total -= detalle.total!;
        venta.ganancias -= detalle.ganancias!;
        state = state.copyWith(
            detalleVentas: state.detalleVentas
                .where((detalle) => detalle.id != id)
                .toList());
      }
      return response;
    } catch (e) {
      return false;
    }
  }
}

class DetalleVentasState {
  final int idventa;
  final bool isLoading;
  final List<DetalleVenta> detalleVentas;

  DetalleVentasState({required this.idventa,this.isLoading = true, this.detalleVentas = const []});

  DetalleVentasState copyWith({
    int? idventa,
    bool? isLoading,
    List<DetalleVenta>? detalleVentas,
  }) =>
      DetalleVentasState(
        idventa: idventa ?? this.idventa,
        isLoading: isLoading ?? this.isLoading,
        detalleVentas: detalleVentas ?? this.detalleVentas,
      );
}
