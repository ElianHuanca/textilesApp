import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final sucursalProvider = StateNotifierProvider.autoDispose
    .family<SucursalNotifier, SucursalState, int>((ref, id) {
  final sucursalesRepository = ref.read(
      sucursalesRepositoryProvider); //ref.watch(sucursalesRepositoryProvider);

  return SucursalNotifier(sucursalesRepository: sucursalesRepository, id: id);
});

class SucursalNotifier extends StateNotifier<SucursalState> {
  final SucursalesRepository sucursalesRepository;

  SucursalNotifier({required this.sucursalesRepository, required int id})
      : super(SucursalState(id: id)) {
    loadSucursal();
  }

  Future<void> loadSucursal() async {
    try {
      if (state.id == 0) {
        state = state.copyWith(sucursal: Sucursal.empty());
        return;
      }
      final sucursal = await sucursalesRepository.getSucursal(state.id);
      state = state.copyWith(sucursal: sucursal);
    } catch (e) {
      print(e);      
    }finally{
      state = state.copyWith(isLoading: false);
    }
  }
}

class SucursalState {
  final int id;
  final Sucursal? sucursal;
  final bool isLoading;

  SucursalState({
    required this.id,
    this.sucursal,
    this.isLoading = true,
  });

  SucursalState copyWith({
    int? id,
    Sucursal? sucursal,
    bool? isLoading,
  }) =>
      SucursalState(
        id: id ?? this.id,
        sucursal: sucursal ?? this.sucursal,
        isLoading: isLoading ?? this.isLoading,
      );
}
