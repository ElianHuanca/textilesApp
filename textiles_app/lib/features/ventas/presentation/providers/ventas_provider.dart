import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final ventasProvider = StateNotifierProvider.autoDispose
    .family<VentasNotifier, VentasState, int>((ref, idsucursal) {
  final ventasRepository = ref.watch(ventasRepositoryProvider);
  return VentasNotifier(
      ventasRepository: ventasRepository, idsucursales: idsucursal);
});

class VentasNotifier extends StateNotifier<VentasState> {
  final VentasRepository ventasRepository;

  VentasNotifier({required this.ventasRepository, required int idsucursales})
      : super(VentasState()) {
    getVentas(idsucursales);
  }

  Future getVentas(int idsucursales) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final ventas = await ventasRepository.getVentas();
    if (ventas.isEmpty) {
      final venta = await ventasRepository.createVentaAhora(idsucursales);
      state = state.copyWith(isLoading: false, ventas: [venta]);
      return;
    }

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    if (today.isAfter(ventas[0].fecha)) {
      final venta = await ventasRepository.createVentaAhora(idsucursales);
      ventas.insert(0, venta);
    }

    state = state.copyWith(isLoading: false, ventas: ventas);
  }

  Future<bool> actualizarVenta(Map<String, dynamic> ventaLike, int id) async {
    try {
      final venta = await ventasRepository.actualizarVenta(ventaLike, id);      
      state = state.copyWith(
          ventas: state.ventas
              .map(
                (element) => (element.id == venta.id) ? venta : element,
              )
              .toList());
      return true;
    } catch (e) {
      return false;
    }
  }
  /* void actualizarVenta(Venta ventaActualizada) {
    int indice =
        state.ventas.indexWhere((venta) => venta.id == ventaActualizada.id);
    if (indice != -1) {
      List<Venta> nuevasVentas = List.from(state.ventas);
      nuevasVentas[indice] = ventaActualizada;
      state = state.copyWith(ventas: nuevasVentas);
    }
  } */
}

class VentasState {
  final bool isLoading;
  final List<Venta> ventas;

  VentasState({
    this.isLoading = false,
    this.ventas = const [],
  });

  VentasState copyWith({bool? isLoading, List<Venta>? ventas}) => VentasState(
        isLoading: isLoading ?? this.isLoading,
        ventas: ventas ?? this.ventas,
      );
}
