import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';

import 'ventas_repository_provider.dart';


final ventasProvider = StateNotifierProvider.autoDispose.family<VentasNotifier, VentasState, int>((ref, idsucursales) {

  final ventasRepository = ref.watch( ventasRepositoryProvider );
  return VentasNotifier(
    ventasRepository: ventasRepository,
    idsucursales: idsucursales
  );
  
});





class VentasNotifier extends StateNotifier<VentasState> {
  
  final VentasRepository ventasRepository;

  VentasNotifier({
    required this.ventasRepository,
    required int idsucursales
  }): super( VentasState()) {
    getVentas(idsucursales);
  }



  Future getVentas(int idsucursales) async {

    if ( state.isLoading ) return;

    state = state.copyWith( isLoading: true );


    final ventas = await ventasRepository.getVentas(idsucursales);

    if ( ventas.isEmpty ) {
      state = state.copyWith(
        isLoading: false,        
      );
      return;
    }
    state = state.copyWith(      
      isLoading: false,
      ventas: ventas
    );
  }
}





class VentasState {
  final bool isLoading;
  final List<Venta> ventas;

  VentasState({
    this.isLoading = false, 
    this.ventas = const[],
  });

  VentasState copyWith({
    bool? isLoading,
    List<Venta>? ventas,
    Venta? selectedVenta
  }) => VentasState(
    isLoading: isLoading ?? this.isLoading,
    ventas: ventas ?? this.ventas,
  );
}