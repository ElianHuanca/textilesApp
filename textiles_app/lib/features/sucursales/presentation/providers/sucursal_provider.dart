import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final sucursalProvider =
    StateNotifierProvider<SucursalNotifier, SucursalState>((ref) {
  final sucursalesRepository = ref.watch(sucursalesRepositoryProvider);

  return SucursalNotifier(sucursalesRepository: sucursalesRepository);
});

class SucursalNotifier extends StateNotifier<SucursalState> {
  final SucursalesRepository sucursalesRepository;

  SucursalNotifier({
    required this.sucursalesRepository,
  }) : super(SucursalState());

  Sucursal newEmptySucursal() {
    return Sucursal(
      id: 0,
      nombre: '',
    );
  }

  Future<void> nuevaSucursal() async {
    state = state.copyWith(
      isLoading: false,
      sucursal: newEmptySucursal(),
    );
  }

  Future<void> setSucursal(Sucursal sucursal) async {
    state = state.copyWith(isLoading: false, sucursal: sucursal);    
  }
}

class SucursalState {
  final Sucursal? sucursal;
  final bool isLoading;
  final bool isSaving;

  SucursalState({
    this.sucursal,
    this.isLoading = true,
    this.isSaving = false,
  });

  SucursalState copyWith({
    Sucursal? sucursal,
    bool? isLoading,
    bool? isSaving,
  }) =>
      SucursalState(
        sucursal: sucursal ?? this.sucursal,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
