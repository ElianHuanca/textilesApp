import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/auth/presentation/providers/auth_provider.dart';
import '../../infrastructure/infrastructure.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final telasProvider = StateNotifierProvider<TelasNotifier, TelasState>((ref) {
  final telasRepository = ref.watch(telasRepositoryProvider);
  return TelasNotifier(
    idusuarios: ref.watch(authProvider).usuario!.id,
    telasRepository: telasRepository,
  );
});

class TelasNotifier extends StateNotifier<TelasState> {
  final TelasRepository telasRepository;
  final int idusuarios;
  TelasNotifier({required this.idusuarios, required this.telasRepository})
      : super(TelasState()) {
    getTelas(idusuarios);
  }

  Future getTelas(int idusuarios) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final telas = await telasRepository.getTelas(idusuarios);

    if (telas.isEmpty) {
      state = state.copyWith(isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: false, telas: telas);
  }

  Future<bool> createTela(Map<String, dynamic> telaLike) async {
    try {
      final tela = await telasRepository.createTela(telaLike, idusuarios);
      state = state.copyWith(telas: [tela, ...state.telas]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTela(Map<String, dynamic> telaLike) async {
    try {
      final response =
          await telasRepository.updateTela(telaLike, telaLike['id']);
      if (!response) return false;
      final Tela tela = TelaMapper.jsonToEntity(telaLike);
      state = state.copyWith(
          telas: state.telas
              .map(
                (element) => (element.id == tela.id) ? tela : element,
              )
              .toList());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTela(int id) async {
    try {
      final response = await telasRepository.deleteTela(id);
      if (!response) return false;
      state = state.copyWith(
          telas: state.telas.where((element) => element.id != id).toList());
      return true;
    } catch (e) {
      return false;
    }
  }
}

class TelasState {
  final bool isLoading;
  final List<Tela> telas;

  TelasState(
      {this.isLoading = false,
      this.telas = const [] // Quitamos la asignación aquí
      }); /* : telas = telas ??
            [              
              Tela(id: 1, nombre: 'Coshibo'),
              Tela(id: 2, nombre: 'Lino'),
              Tela(id: 3, nombre: 'Seda'),
              Tela(id: 4, nombre: 'Algodón'),
              Tela(id: 5, nombre: 'Lana'),
              Tela(id: 6, nombre: 'Poliester'),
              Tela(id: 7, nombre: 'Nylon'),
              Tela(id: 8, nombre: 'Licra'),
              Tela(id: 9, nombre: 'Spandex'),
              Tela(id: 10, nombre: 'Rayón'),
            ];  */

  TelasState copyWith({bool? isLoading, List<Tela>? telas}) {
    return TelasState(
      isLoading: isLoading ?? this.isLoading,
      telas: telas ?? this.telas,
    );
  }
}
