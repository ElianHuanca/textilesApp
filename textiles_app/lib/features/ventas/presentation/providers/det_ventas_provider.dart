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
      {    
      this.actualizarVenta,
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
      List<Map<String, dynamic>> detalleVentasLike) async {
    try {
      final Venta venta = getVenta!();
      double total = 0;
      double ganancias = 0;
      for (var detalle in detalleVentasLike) {
        total += detalle['total'] ?? 0.0;
        ganancias += detalle['ganancia'] ?? 0.0;
      }
      venta.total = total;
      venta.ganancias = ganancias;

      setVenta!(venta);
      actualizarVenta!(venta);

      final response = await detalleVentasRepository.createDetalleVenta(
          detalleVentasLike, venta.id);

      state =
          state.copyWith(detalleVentas: [...response, ...state.detalleVentas]);

      //final data = {'total': total, 'ganancias': ganancias};
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
