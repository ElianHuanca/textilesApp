import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final detalleVentasProvider =
    StateNotifierProvider<DetalleVentasNotifier, DetalleVentasState>((ref) {
  final detalleVentasRepository = ref.watch(detalleVentasRepositoryProvider);
  final setVenta = ref.watch(ventaProvider.notifier).setVenta;
  final obtenerVenta = ref.watch(ventaProvider.notifier).getVenta;
  final actualizaVenta = ref.watch(ventasProvider.notifier).actualizarVenta;
  return DetalleVentasNotifier(
      actualizarVenta: actualizaVenta,
      detalleVentasRepository: detalleVentasRepository,
      setVenta: setVenta,
      getVenta: obtenerVenta);
});

class DetalleVentasNotifier extends StateNotifier<DetalleVentasState> {
  final Function(Venta)? actualizarVenta;
  final Function(Venta)? setVenta;
  final Function? getVenta;
  final DetalleVentasRepository detalleVentasRepository;

  DetalleVentasNotifier(
      {this.actualizarVenta,
      required this.detalleVentasRepository,
      this.getVenta,
      this.setVenta})
      : super(DetalleVentasState()) {
    getDetVenta(getVenta!().id);
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
      List<Map<String, dynamic>> detalleVentasLike, double descuento) async {
    try {
      final Venta venta = getVenta!();
      for (var detalle in detalleVentasLike) {
        venta.total += detalle['total'] ?? 0.0;
        venta.ganancias += detalle['ganancias'] ?? 0.0;
      }
      venta.descuento += descuento;
      print(venta.total);
      print(venta.ganancias);
      print(venta.descuento);
      setVenta!(venta);
      actualizarVenta!(venta);
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
