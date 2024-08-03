import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final telaProvider = StateNotifierProvider.autoDispose.family<TelaNotifier, TelaState,int>((ref,id) {
  final telasRepository = ref.watch(telasRepositoryProvider);

  return TelaNotifier(telasRepository: telasRepository,id:id);
});

class TelaNotifier extends StateNotifier<TelaState> {
  final TelasRepository telasRepository;

  TelaNotifier({
    required this.telasRepository,
    required int id,
  }) : super(TelaState(id:id));

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
  
  Future<void> loadTela() async {
    try {
      if (state.id == 0) {
        state = state.copyWith(isLoading: false, tela: newEmptyTela());
        return;
      }
      final tela = await telasRepository.getTela(state.id);

      state = state.copyWith(isLoading: false, tela: tela);
    } catch (e) {
      print(e);
    }
  }
}

class TelaState {
  final int id;  
  final Tela? tela;  
  final bool isLoading;

  TelaState({
    required this.id,
    this.tela,    
    this.isLoading = true,
  });

  TelaState copyWith({
    Tela? tela,    
    int? id,
    bool? isLoading,
  }) =>
      TelaState(
        tela: tela ?? this.tela,
        id: id ?? this.id,
        isLoading: isLoading ?? this.isLoading,
      );
}
