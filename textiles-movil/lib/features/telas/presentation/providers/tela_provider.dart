import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/telas/domain/domain.dart';
import 'package:teslo_shop/features/telas/presentation/providers/providers.dart';

final telaProvider = StateNotifierProvider.autoDispose
    .family<TelaNotifier, TelaState, String>((ref, id) {
  final telasRepository = ref.watch(telasRepositoryProvider);

  return TelaNotifier(telasRepository: telasRepository, id: int.parse(id));
});

class TelaNotifier extends StateNotifier<TelaState> {
  final TelasRepository telasRepository;

  TelaNotifier({required this.telasRepository, required int id})
      : super(TelaState(id: id));

  Tela nuevaTela() {
    return Tela(
        id: 0,
        nombre: '',
        precxcompra: 0,
        precxmen: 0,
        precxmay: 0,
        precxrollo: 0);
  }

  Future<void> cargarTela() async {
    try {
      if (state.id == 0) {
        state = state.copyWith(tela: nuevaTela(), isLoading: false);
        return;
      }
      
    } catch (e) {
      print(e);
    }
  }
}

class TelaState {
  final int id;
  final Tela? tela;
  final bool isLoading;
  final bool isSaving;

  TelaState(
      {required this.id,
      this.tela,
      this.isLoading = true,
      this.isSaving = false});
  TelaState copyWith({int? id, Tela? tela, bool? isLoading, bool? isSaving}) =>
      TelaState(
          id: id ?? this.id,
          tela: tela ?? this.tela,
          isLoading: isLoading ?? this.isLoading,
          isSaving: isSaving ?? this.isSaving);
}
