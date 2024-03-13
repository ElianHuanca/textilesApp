import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final ventaProvider = StateNotifierProvider<VentaNotifier,VentaState>((ref){
  final ventasRepository = ref.watch(ventasRepositoryProvider);
  final onGetVenta = ref.watch(ventasProvider.notifier).getVenta;
  return VentaNotifier(ventasRepository: ventasRepository, onGetVenta: onGetVenta);
});

class VentaNotifier extends StateNotifier<VentaState> {
  final VentasRepository ventasRepository;
  final Future<Venta> Function(int id)? onGetVenta;
  VentaNotifier({this.onGetVenta,required this.ventasRepository})
      : super(VentaState());

  Future<void> setVenta( Venta venta ) async {
    state = state.copyWith(
      venta: venta
    );
  }

  Future<void> actualizarVenta() async {
    final venta = await onGetVenta!(state.venta!.id);
    await setVenta(venta);
  }
}

class VentaState {  
  final Venta? venta;
  final bool isLoading;  

  VentaState({
    this.venta,
    this.isLoading = true,    
  });

  VentaState copyWith({    
    Venta? venta,
    bool? isLoading,
    bool? isSaving,
  }) {
    return VentaState(      
      venta: venta ?? this.venta,
      isLoading: isLoading ?? this.isLoading,      
    );
  }
}
