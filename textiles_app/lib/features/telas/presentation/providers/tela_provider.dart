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

  void nuevaTela()  {
    state = state.copyWith(      
      tela: newEmptyTela(),
    );
  }

  void setTela(Tela tela) {
    state = state.copyWith( tela: tela);
  }
}

class TelaState {
  final Tela? tela;  

  TelaState({
    this.tela,    
  });

  TelaState copyWith({
    Tela? tela,    
  }) =>
      TelaState(
        tela: tela ?? this.tela,
      );
}
