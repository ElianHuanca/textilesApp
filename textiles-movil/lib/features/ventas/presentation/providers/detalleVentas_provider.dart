import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/ventas/domain/domain.dart';
import 'package:teslo_shop/features/ventas/presentation/providers/detalleVentas_repository_provider.dart';
import 'package:teslo_shop/features/ventas/presentation/providers/providers.dart';

final detalleVentasProvider =
    StateNotifierProvider<DetalleVentasNotifier, DetalleVentasState>((ref) {
  final detalleVentasRepository = ref.watch(detalleVentasRepositoryProvider);
  final idventas = ref.watch(ventasProvider).selectedVenta.id;
  return DetalleVentasNotifier(
      detalleVentasRepository: detalleVentasRepository,
      idVentas: idventas);
});

class DetalleVentasNotifier extends StateNotifier<DetalleVentasState> {
  final DetalleVentasRepository detalleVentasRepository;
  final int idVentas;

  DetalleVentasNotifier({required this.idVentas, required this.detalleVentasRepository})
      : super(DetalleVentasState()) {
    loadNextPage(idVentas);
  }

  Future loadNextPage(int idVenta) async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final detalleVentas =
        await detalleVentasRepository.getDetalleVenta(idVenta);

    if (detalleVentas.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        detalleVentas: [...state.detalleVentas, ...detalleVentas]);
  }
}

class DetalleVentasState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<DetalleVenta> detalleVentas;

  DetalleVentasState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.detalleVentas = const []});

  DetalleVentasState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<DetalleVenta>? detalleVentas,
  }) =>
      DetalleVentasState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        detalleVentas: detalleVentas ?? this.detalleVentas,
      );
}
