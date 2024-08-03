import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final ventaProvider = StateNotifierProvider.autoDispose.family<VentaNotifier,VentaState,int>((ref,id){
  final ventasRepository = ref.watch(ventasRepositoryProvider);  
  return VentaNotifier(ventasRepository: ventasRepository,id:id);
});

class VentaNotifier extends StateNotifier<VentaState> {
  final VentasRepository ventasRepository;  
  VentaNotifier({required this.ventasRepository, required int id})
      : super(VentaState(id:id));

  Future<void> loadTela() async {
    try {      
      final venta = await ventasRepository.getVenta(state.id);

      state = state.copyWith(isLoading: false, venta: venta);
    } catch (e) {
      print(e);
    }
  }
  
  /* Venta getVenta() {
    return state.venta!;
  }

  void setVenta( Venta venta ) {
    state = state.copyWith(
      venta: venta
    );
  } */

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
