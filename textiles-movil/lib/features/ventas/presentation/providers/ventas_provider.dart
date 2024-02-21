import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/ventas/domain/domain.dart';

import 'ventas_repository_provider.dart';


final ventasProvider = StateNotifierProvider<VentasNotifier, VentasState>((ref) {

  final ventasRepository = ref.watch( ventasRepositoryProvider );
  return VentasNotifier(
    ventasRepository: ventasRepository
  );
  
});





class VentasNotifier extends StateNotifier<VentasState> {
  
  final VentasRepository ventasRepository;

  VentasNotifier({
    required this.ventasRepository
  }): super( VentasState(selectedVenta: Venta(id: 0, fecha: '', total: 0, ganancias: 0)) ) {
    loadNextPage();
  }

  Future<bool> createOrUpdateVenta( Map<String,dynamic> ventaLike ) async {

    try {
      final venta = await ventasRepository.createUpdateVenta(ventaLike);
      final isventaInList = state.ventas.any((element) => element.id == venta.id );

      if ( !isventaInList ) {
        state = state.copyWith(
          ventas: [...state.ventas, venta]
        );
        return true;
      }

      state = state.copyWith(
        ventas: state.ventas.map(
          (element) => ( element.id == venta.id ) ? venta : element,
        ).toList()
      );
      return true;

    } catch (e) {
      return false;
    }


  }



  Future loadNextPage() async {

    if ( state.isLoading || state.isLastPage ) return;

    state = state.copyWith( isLoading: true );


    final ventas = await ventasRepository
      .getVentasByPage(limit: state.limit, offset: state.offset );

    if ( ventas.isEmpty ) {
      state = state.copyWith(
        isLoading: false,
        isLastPage: true
      );
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      ventas: [...state.ventas, ...ventas ]
    );


  }

  Future setSelectedVenta( Venta venta ) async {
    state = state.copyWith(
      selectedVenta: venta
    );
  }  


}





class VentasState {

  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Venta> ventas;
  final Venta selectedVenta;

  VentasState({
    this.isLastPage = false, 
    this.limit = 10, 
    this.offset = 0, 
    this.isLoading = false, 
    this.ventas = const[],
    required this.selectedVenta 
  });

  VentasState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Venta>? ventas,
    Venta? selectedVenta
  }) => VentasState(
    isLastPage: isLastPage ?? this.isLastPage,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    isLoading: isLoading ?? this.isLoading,
    ventas: ventas ?? this.ventas,
    selectedVenta: selectedVenta ?? this.selectedVenta
  );
}
