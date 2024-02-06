import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/ventas/domain/domain.dart';

import 'products_repository_provider.dart';


final ventasProvider = StateNotifierProvider<VentasNotifier, ProductsState>((ref) {

  final ventasRepository = ref.watch( ventasRepositoryProvider );
  return VentasNotifier(
    ventasRepository: ventasRepository
    //productsRepository: productsRepository
  );
  
});





class VentasNotifier extends StateNotifier<ProductsState> {
  
  final VentasRepository ventasRepository;

  VentasNotifier({
    required this.ventasRepository
  }): super( ProductsState() ) {
    loadNextPage();
  }

  /* Future<bool> createOrUpdateProduct( Map<String,dynamic> productLike ) async {

    try {
      final product = await productsRepository.createUpdateProduct(productLike);
      final isProductInList = state.products.any((element) => element.id == product.id );

      if ( !isProductInList ) {
        state = state.copyWith(
          products: [...state.products, product]
        );
        return true;
      }

      state = state.copyWith(
        products: state.products.map(
          (element) => ( element.id == product.id ) ? product : element,
        ).toList()
      );
      return true;

    } catch (e) {
      return false;
    }


  } */

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

}





class ProductsState {

  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Venta> ventas;

  ProductsState({
    this.isLastPage = false, 
    this.limit = 10, 
    this.offset = 0, 
    this.isLoading = false, 
    this.ventas = const[]
  });

  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Venta>? ventas,
  }) => ProductsState(
    isLastPage: isLastPage ?? this.isLastPage,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    isLoading: isLoading ?? this.isLoading,
    ventas: ventas ?? this.ventas,
  );

}
