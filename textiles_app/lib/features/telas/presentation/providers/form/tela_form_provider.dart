import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

final telaFormProvider = StateNotifierProvider.autoDispose
    .family<TelaFormNotifier, TelaFormState, Tela>((ref, tela) {
  final createUpdateCallback = ref.watch(telasProvider.notifier).createTela;
  final updateCallback = ref.watch(telasProvider.notifier).updateTela;
  final deleteCallback = ref.watch(telasProvider.notifier).deleteTela;
  return TelaFormNotifier(
    tela: tela,
    onCreateCallback: createUpdateCallback,
    onUpdateCallback: updateCallback,
    onDeleteCallback: deleteCallback,
  );
});

class TelaFormNotifier extends StateNotifier<TelaFormState> {
  final Future<bool> Function(Map<String, dynamic> telaLike)? onCreateCallback;
  final Future<bool> Function(Map<String, dynamic> telaLike)? onUpdateCallback;
  final Future<bool> Function(int id)? onDeleteCallback;
  TelaFormNotifier({
    this.onCreateCallback,
    this.onUpdateCallback,
    this.onDeleteCallback,
    required Tela tela,
  }) : super(TelaFormState(
          id: tela.id,
          nombre: tela.nombre,
          precxmen: tela.precxmen != 0 ? tela.precxmen.toString() : '',
          precxmay: tela.precxmay != 0 ? tela.precxmay.toString() : '',
          precxrollo: tela.precxrollo != 0 ? tela.precxrollo.toString() : '',
          precxcompra: tela.precxcompra != 0 ? tela.precxcompra.toString() : '',
        ));

  Future<bool> onCreateSubmit() async {    
    if (onCreateCallback == null) return false;
    if (validadorVacio()) return false;
    if (validadorDecimal()) return false;
    final telaLike = telaToMap();
    try {
      return await onCreateCallback!(telaLike);
    } catch (e) {
      return false;
    }
  }

  Future<bool> onUpdateSubmit() async {
    if (onUpdateCallback == null) return false;
    if (validadorVacio()) return false;
    if (validadorDecimal()) return false;
    final telaLike = telaToMap();
    try {
      return await onUpdateCallback!(telaLike);
    } catch (e) {
      return false;
    }
  }

  Future<bool> onDeleteSubmit() async {
    if (onDeleteCallback == null) return false;
    try {
      return await onDeleteCallback!(state.id!);
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> telaToMap() {
    return {
      'id': state.id,
      'nombre': state.nombre,
      'precxmen': double.parse(state.precxmen),
      'precxmay': double.parse(state.precxmay),
      'precxrollo': double.parse(state.precxrollo),
      'precxcompra': double.parse(state.precxcompra),
    };
  }

  bool validadorVacio() {
    return state.nombre.isEmpty ||
        state.precxmen.isEmpty ||
        state.precxmay.isEmpty ||
        state.precxrollo.isEmpty ||
        state.precxcompra.isEmpty;
  }

  bool validadorDecimal() {
    return double.tryParse(state.precxmen) == null ||
        double.tryParse(state.precxmay) == null ||
        double.tryParse(state.precxrollo) == null ||
        double.tryParse(state.precxcompra) == null;
  }

  void onNombreChanged(String value) {
    state = state.copyWith(
      nombre: value,
    );
  }

  void onPrecxmenChanged(String value) {
    state = state.copyWith(
      precxmen: value,
    );
  }

  void onPrecxmayChanged(String value) {
    state = state.copyWith(
      precxmay: value,
    );
  }

  void onPrecxrolloChanged(String value) {
    state = state.copyWith(
      precxrollo: value,
    );
  }

  void onPrecxcompraChanged(String value) {
    state = state.copyWith(
      precxcompra: value,
    );
  }
}

class TelaFormState {  
  final int? id;
  final String nombre;
  final String precxmen;
  final String precxmay;
  final String precxrollo;
  final String precxcompra;

  TelaFormState({    
    this.id,
    this.nombre = '',
    this.precxmen = '',
    this.precxmay = '',
    this.precxrollo = '',
    this.precxcompra = '',
  });

  TelaFormState copyWith({
    int? id,
    String? nombre,
    String? precxmen,
    String? precxmay,
    String? precxrollo,
    String? precxcompra,
  }) =>
      TelaFormState(        
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        precxmen: precxmen ?? this.precxmen,
        precxmay: precxmay ?? this.precxmay,
        precxrollo: precxrollo ?? this.precxrollo,
        precxcompra: precxcompra ?? this.precxcompra,
      );
}
