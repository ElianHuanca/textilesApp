import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final ventaProvider = StateNotifierProvider.autoDispose
    .family<VentaNotifier, VentaState, int>((ref, id) {
  final ventasRepository = ref.watch(ventasRepositoryProvider);
  return VentaNotifier(ventasRepository: ventasRepository, id: id);
});

class VentaNotifier extends StateNotifier<VentaState> {
  final VentasRepository ventasRepository;
  VentaNotifier({required this.ventasRepository, required int id})
      : super(VentaState(id: id)) {
    loadVenta();
  }

  Future<void> loadVenta() async {
    try {
      final venta = await ventasRepository.getVenta(state.id);
      state = state.copyWith(venta: venta);
    } catch (e) {
      print("Error al obtener venta: $e");      
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

class VentaState {
  final int id;
  final Venta? venta;
  final bool isLoading;

  VentaState({
    required this.id,
    this.venta,
    this.isLoading = true,
  });

  VentaState copyWith({
    int? id,
    Venta? venta,
    bool? isLoading,
    bool? isSaving,
  }) {
    return VentaState(
      id: id ?? this.id,
      venta: venta ?? this.venta,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
