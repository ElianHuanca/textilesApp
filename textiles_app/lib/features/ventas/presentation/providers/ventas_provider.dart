import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/sucursales/presentation/providers/providers.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final ventasProvider =
    StateNotifierProvider<VentasNotifier, VentasState>((ref) {
  final ventasRepository = ref.watch(ventasRepositoryProvider);
  return VentasNotifier(
      ventasRepository: ventasRepository,
      idsucursales: ref.watch(sucursalProvider).sucursal!.id);
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

    final ventas = await ventasRepository.getVentas(idsucursales);

    if (ventas.isEmpty) {
      final venta = await ventasRepository.createVentaAhora(idsucursales);
      state = state.copyWith(isLoading: false, ventas: [venta]);
      return;
    }

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime ventaDate = DateTime.parse(ventas[0].fecha);
    DateTime ventaDateOnly =
        DateTime(ventaDate.year, ventaDate.month, ventaDate.day);
    print(today.isAfter(ventaDateOnly));
    if (today.isAfter(ventaDateOnly)) {
      final venta = await ventasRepository.createVentaAhora(idsucursales);
      ventas.insert(0, venta);
    }

    state = state.copyWith(isLoading: false, ventas: ventas);
  }

  Future<Venta> getVenta(int id) async {
    final venta = await ventasRepository.getVenta(id);
    actualizarVenta(venta);
    return venta;
  }

  actualizarVenta(Venta ventaActualizada) async {
    // Encuentra el índice de la venta correspondiente en la lista de ventas
    int indice =
        state.ventas.indexWhere((venta) => venta.id == ventaActualizada.id);

    // Verifica si se encontró la venta
    if (indice != -1) {
      // Crea una copia de la lista de ventas
      List<Venta> nuevasVentas = List.from(state.ventas);

      // Reemplaza la venta existente con la venta actualizada
      nuevasVentas[indice] = ventaActualizada;

      // Actualiza el estado con la nueva lista de ventas
      state = state.copyWith(ventas: nuevasVentas);
    } else {
      // Maneja el caso donde no se encontró la venta
      print('Venta con ID ${ventaActualizada.id} no encontrada');
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

  VentasState copyWith(
          {bool? isLoading, List<Venta>? ventas, Venta? selectedVenta}) =>
      VentasState(
        isLoading: isLoading ?? this.isLoading,
        ventas: ventas ?? this.ventas,
      );
}
