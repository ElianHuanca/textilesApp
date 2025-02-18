import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final ventasProvider = StateNotifierProvider.autoDispose
    .family<VentasNotifier, VentasState, int>((ref, idsucursal) {
  final ventasRepository = ref.watch(ventasRepositoryProvider);
  return VentasNotifier(
      ventasRepository: ventasRepository, idsucursal: idsucursal);
});

class VentasNotifier extends StateNotifier<VentasState> {
  final VentasRepository ventasRepository;

  VentasNotifier({required this.ventasRepository, required int idsucursal})
      : super(VentasState()) {
    getVentas(idsucursal);
  }

  Future getVentas(int idsucursal) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      final ventas = await ventasRepository.getVentas(idsucursal);

      if (ventas.isEmpty) {
        final venta = await ventasRepository.createVentaAhora(idsucursal);
        state = state.copyWith(ventas: [venta]);
        return;
      }

      DateTime now = DateTime.now();
      //DateTime today = DateTime(now.year, now.month, now.day);
      if (ventas[0].fecha.isBefore(DateTime(now.year, now.month, now.day))) {
        final venta = await ventasRepository.createVentaAhora(idsucursal);
        ventas.insert(0, venta);
      }
      state = state.copyWith(ventas: ventas);
    } catch (e) {
      print("Error al obtener ventas: $e");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  } 
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
