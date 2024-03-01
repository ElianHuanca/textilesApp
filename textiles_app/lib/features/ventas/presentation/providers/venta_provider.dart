import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import 'package:textiles_app/features/ventas/presentation/providers/providers.dart';

final ventaProvider = StateNotifierProvider<VentaNotifier,VentaState>((ref){
  final ventasRepository = ref.watch(ventasRepositoryProvider);
  return VentaNotifier(ventasRepository: ventasRepository);
});

class VentaNotifier extends StateNotifier<VentaState> {
  final VentasRepository ventasRepository;
  VentaNotifier({required this.ventasRepository})
      : super(VentaState());

  Future setVenta( Venta venta ) async {
    state = state.copyWith(
      venta: venta
    );
  }
}

class VentaState {
  //final int id;
  final Venta? venta;
  final bool isLoading;  

  VentaState({
    //required this.id,
    this.venta,
    this.isLoading = true,    
  });

  VentaState copyWith({
    //int? id,
    Venta? venta,
    bool? isLoading,
    bool? isSaving,
  }) {
    return VentaState(
      //id: id ?? this.id,
      venta: venta ?? this.venta,
      isLoading: isLoading ?? this.isLoading,      
    );
  }
}
