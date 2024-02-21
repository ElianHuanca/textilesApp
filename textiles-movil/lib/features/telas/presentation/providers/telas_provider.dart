import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/telas/domain/domain.dart';
import 'package:teslo_shop/features/telas/presentation/providers/providers.dart';


final telasProvider = StateNotifierProvider<TelasNotifier, TelasState>((ref){
  final telasRepository = ref.watch(telasRepositoryProvider);
  return TelasNotifier(telasRepository : telasRepository);
});

class TelasNotifier extends StateNotifier<TelasState>{
  final TelasRepository telasRepository;
  TelasNotifier({required this.telasRepository}):super(TelasState()){
    getTelas();
  }

  Future getTelas()async{
    if(state.isLoading) return;
    
    state = state.copyWith(isLoading: true);

    final telas = await telasRepository.getTelas();

    if(telas.isEmpty){
      state = state.copyWith(isLoading: false);
      return;
    }

    state = state.copyWith(
      isLoading: false,
      telas: [...telas],
    );
  }
}

class TelasState{
  final bool isLoading;
  final List<Tela> telas;
  TelasState({    
    this.isLoading=false,
    this.telas=const [],
  });

  TelasState copyWith({
    bool? isLoading,
    List<Tela>? telas,
  })=>TelasState(
      isLoading: isLoading ?? this.isLoading,
      telas: telas ?? this.telas,
  ); 
}