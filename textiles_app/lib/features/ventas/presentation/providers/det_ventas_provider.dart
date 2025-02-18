import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final detalleVentasProvider = StateNotifierProvider.autoDispose
    .family<DetalleVentasNotifier, DetalleVentasState, int>((ref, idventa) {
  final detalleVentasRepository = ref.watch(detalleVentasRepositoryProvider);
  final updateVentaCallback =
      ref.watch(ventaProvider(idventa).notifier).actualizarVenta;
  return DetalleVentasNotifier(
      detalleVentasRepository: detalleVentasRepository,
      updateVenta: updateVentaCallback,
      idventa: idventa);
});

class DetalleVentasNotifier extends StateNotifier<DetalleVentasState> {
  final DetalleVentasRepository detalleVentasRepository;
  final Future<bool> Function(Map<String, dynamic> ventaLike) updateVenta;
  DetalleVentasNotifier(
      {required this.updateVenta,
      required this.detalleVentasRepository,
      required int idventa})
      : super(DetalleVentasState(idventa: idventa)) {
    getDetVenta(idventa);
  }

  Future getDetVenta(int idventa) async {
    try {
      final detalleVentas =
          await detalleVentasRepository.getDetalleVenta(idventa);
      if (detalleVentas.isEmpty) return;
      state = state.copyWith(detalleVentas: detalleVentas);
    } catch (e) {
      print("Error al obtener detalle ventas: $e");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool> createDetVenta(
      List<Map<String, dynamic>> detalleVentasLike) async {
    try {
      final response = await detalleVentasRepository.createDetalleVenta(
          detalleVentasLike, state.idventa);
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
      final ventaLike = {
        'total': -response.total!,
        'ganancias': -response.ganancias!,
        'descuento':0
      };      
      state = state.copyWith(
          detalleVentas: state.detalleVentas
              .where((detalle) => detalle.id != id)
              .toList());
      return await updateVenta(ventaLike);
    } catch (e) {
      return false;
    }
  }
}

class DetalleVentasState {
  final int idventa;
  final bool isLoading;
  final List<DetalleVenta> detalleVentas;

  DetalleVentasState(
      {required this.idventa,
      this.isLoading = true,
      this.detalleVentas = const []});

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
