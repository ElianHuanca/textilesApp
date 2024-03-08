import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/auth/presentation/providers/auth_provider.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final sucursalesProvider =
    StateNotifierProvider<SucursalesNotifier, SucursalesState>((ref) {
  final sucursalesRepository = ref.watch(sucursalesRepositoryProvider);
  return SucursalesNotifier(
    idusuarios: ref.watch(authProvider).usuario!.id,
    sucursalesRepository: sucursalesRepository,
  );
});

class SucursalesNotifier extends StateNotifier<SucursalesState> {
  final SucursalesRepository sucursalesRepository;
  final int idusuarios;
  SucursalesNotifier(
      {required this.idusuarios, required this.sucursalesRepository})
      : super(SucursalesState()) {
    getSucursales(idusuarios);
  }

  Future getSucursales(int idusuarios) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final sucursales = await sucursalesRepository.getSucursales(idusuarios);

    if (sucursales.isEmpty) {
      state = state.copyWith(isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: false, sucursales: sucursales);
  }

  Future<bool> createOrUpdateSucursal(Map<String, dynamic> sucursalLike,int idusuarios) async {
    try {
      final sucursal = await sucursalesRepository.createUpdateSucursal(sucursalLike, idusuarios);
      final isSucursalInList =
          state.sucursales.any((element) => element.id == sucursal.id);

      if (!isSucursalInList) {
        state = state.copyWith(sucursales: [...state.sucursales, sucursal]);
        return true;
      }

      state = state.copyWith(
          sucursales: state.sucursales
              .map(
                (element) => (element.id == sucursal.id) ? sucursal : element,
              )
              .toList());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteSucursal(int id) async {
    try {
      sucursalesRepository.deleteSucursal(id);
      state = state.copyWith(
          sucursales: state.sucursales
              .where((element) => element.id != id)
              .toList());
      return true;
    } catch (e) {
      return false;
    }
  }
}

class SucursalesState {
  final bool isLoading;
  final List<Sucursal> sucursales;

  SucursalesState({this.isLoading = false, this.sucursales = const []});

  SucursalesState copyWith({bool? isLoading, List<Sucursal>? sucursales}) {
    return SucursalesState(
      isLoading: isLoading ?? this.isLoading,
      sucursales: sucursales ?? this.sucursales,
    );
  }
}
