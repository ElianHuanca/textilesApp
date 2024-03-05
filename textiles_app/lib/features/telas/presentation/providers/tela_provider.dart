import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final telaProvider = StateNotifierProvider<TelaNotifier, TelaState>((ref) {
  final telasRepository = ref.watch(telasRepositoryProvider);

  return TelaNotifier(telasRepository: telasRepository);
});

class TelaNotifier extends StateNotifier<TelaState> {
  final TelasRepository telasRepository;

  TelaNotifier({
    required this.telasRepository,
  }) : super(TelaState());

  Tela newEmptyTela() {
    return Tela(
      id: 0,
      nombre: '',
      precxmen: 0,
      precxmay: 0,
      precxrollo: 0,
      precxcompra: 0,
    );
  }

  Future<void> nuevaTela() async {
    state = state.copyWith(
      isLoading: false,
      tela: newEmptyTela(),
    );
  }

  Future<void> setTela(Tela tela) async {
    state = state.copyWith(isLoading: false, tela: tela);
  }
}

class TelaState {
  final Tela? tela;
  final bool isLoading;
  final bool isSaving;

  TelaState({
    this.tela,
    this.isLoading = true,
    this.isSaving = false,
  });

  TelaState copyWith({
    Tela? tela,
    bool? isLoading,
    bool? isSaving,
  }) =>
      TelaState(
        tela: tela ?? this.tela,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
