import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import 'providers.dart';

final telasProvider = StateNotifierProvider<TelasNotifier, TelasState>((ref) {
  final telasRepository = ref.watch(telasRepositoryProvider);
  return TelasNotifier(    
    telasRepository: telasRepository,
  );
});

class TelasNotifier extends StateNotifier<TelasState> {
  final TelasRepository telasRepository;  
  TelasNotifier({required this.telasRepository})
      : super(TelasState()) {
    getTelas();
  }

  Future getTelas() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final telas = await telasRepository.getTelas();

    if (telas.isEmpty) {
      state = state.copyWith(isLoading: false);
      return;
    }

    state = state.copyWith(isLoading: false, telas: telas);
  }

  Future<bool> createTela(Map<String, dynamic> telaLike) async {
    try {
      final tela = await telasRepository.createTela(telaLike);
      state = state.copyWith(telas: [tela, ...state.telas]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTela(Map<String, dynamic> telaLike) async {
    try {
      final tela =
          await telasRepository.updateTela(telaLike, telaLike['id']);      
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
      {this.isLoading = true,
      this.telas = const [] 
      }); 

  TelasState copyWith({bool? isLoading, List<Tela>? telas}) {
    return TelasState(
      isLoading: isLoading ?? this.isLoading,
      telas: telas ?? this.telas,
    );
  }
}
