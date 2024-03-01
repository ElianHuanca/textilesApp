import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:textiles_app/features/sucursales/domain/domain.dart';
import 'package:textiles_app/features/sucursales/presentation/providers/sucursales_repository_provider.dart';

final sucursalesProvider = StateNotifierProvider<SucursalesNotifier,SucursalesState>((ref) {
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
}

class SucursalesState {
  final bool isLoading;
  final List<Sucursal> sucursales;

  SucursalesState({this.isLoading = false, this.sucursales = const []});

  SucursalesState copyWith({bool? isLoading, List<Sucursal>? sucursales}) {
    //SI HAY PROBLEMAS ES AQUI
    return SucursalesState(
      isLoading: isLoading ?? this.isLoading,
      sucursales: sucursales ?? this.sucursales,
    );
  }
}
