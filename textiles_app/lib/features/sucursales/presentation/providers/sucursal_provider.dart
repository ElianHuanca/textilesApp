import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final sucursalProvider = StateNotifierProvider.autoDispose
    .family<SucursalNotifier, SucursalState, int>((ref, id) {
  final sucursalesRepository = ref.watch(sucursalesRepositoryProvider);

  return SucursalNotifier(sucursalesRepository: sucursalesRepository, id: id);
});

class SucursalNotifier extends StateNotifier<SucursalState> {
  final SucursalesRepository sucursalesRepository;  
  SucursalNotifier({required this.sucursalesRepository, required int id})
      : super(SucursalState(id:id));

  Sucursal newEmptySucursal() {
    return Sucursal(
      id: 0,
      nombre: '',
    );
  }

  Future<void> loadSucursal() async {
    try{
      if( state.id == 0){
        state = state.copyWith(isLoading: false, sucursal: newEmptySucursal());
        return;
      }
      final sucursal = await sucursalesRepository.getSucursal(state.id);

      state = state.copyWith(isLoading: false, sucursal: sucursal);
    }catch(e){
      //404 product not found
      print(e);
    }
  }
  /* Future<void> nuevaSucursal() async {
    state = state.copyWith(
      isLoading: false,
      sucursal: newEmptySucursal(),
    );
  } */

  /* Future<void> setSucursal(Sucursal sucursal) async {
    state = state.copyWith(isLoading: false, sucursal: sucursal);
  } */
}

class SucursalState {
  final int id;
  final Sucursal? sucursal;
  final bool isLoading;
  final bool isSaving;

  SucursalState({
    required this.id,
    this.sucursal,
    this.isLoading = true,
    this.isSaving = false,
  });

  SucursalState copyWith({
    int? id,
    Sucursal? sucursal,
    bool? isLoading,
    bool? isSaving,
  }) =>
      SucursalState(
        id: id ?? this.id,
        sucursal: sucursal ?? this.sucursal,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
