import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final sucursalesProvider =
    StateNotifierProvider<SucursalesNotifier, SucursalesState>((ref) {
  final sucursalesRepository = ref.watch(sucursalesRepositoryProvider);
  return SucursalesNotifier(
    sucursalesRepository: sucursalesRepository,
  );
});

class SucursalesNotifier extends StateNotifier<SucursalesState> {
  final SucursalesRepository sucursalesRepository;
  
  SucursalesNotifier(
      {required this.sucursalesRepository})
      : super(SucursalesState()) {
    getSucursales();
  }

  Future getSucursales() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final sucursales = await sucursalesRepository.getSucursales();

    if (sucursales.isEmpty) {
      state = state.copyWith(isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: false, sucursales: sucursales);
  }

  Future<bool> createSucursal(Map<String, dynamic> sucursalLike) async {
    try {
      final sucursal =
          await sucursalesRepository.createSucursal(sucursalLike);
      state = state.copyWith(sucursales: [...state.sucursales, sucursal]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateSucursal(Map<String, dynamic> sucursalLike) async {
    try {
      final sucursal = await sucursalesRepository.updateSucursal(
          sucursalLike, sucursalLike['id']);            
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
      final response = await sucursalesRepository.deleteSucursal(id);
      if (!response) return false;
      state = state.copyWith(
          sucursales:
              state.sucursales.where((element) => element.id != id).toList());
      return true;
    } catch (e) {
      return false;
    }
  }
}

class SucursalesState {
  final bool isLoading;
  final List<Sucursal> sucursales;

  SucursalesState({this.isLoading = true, this.sucursales = const []});

  SucursalesState copyWith({bool? isLoading, List<Sucursal>? sucursales}) {
    return SucursalesState(
      isLoading: isLoading ?? this.isLoading,
      sucursales: sucursales ?? this.sucursales,
    );
  }
}
