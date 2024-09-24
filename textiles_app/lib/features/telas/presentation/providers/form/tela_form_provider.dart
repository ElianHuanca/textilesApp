import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

final telaFormProvider = StateNotifierProvider.autoDispose
    .family<TelaFormNotifier, TelaFormState, Tela>((ref, tela) {
  final telasNotifier = ref.watch(telasProvider.notifier);
  return TelaFormNotifier(
    tela: tela,
    onCreateCallback: telasNotifier.createTela,
    onUpdateCallback: telasNotifier.updateTela,
    onDeleteCallback: telasNotifier.deleteTela,
  );
});

class TelaFormNotifier extends StateNotifier<TelaFormState> {
  final Future<bool> Function(Map<String, dynamic> telaLike) onCreateCallback;
  final Future<bool> Function(Map<String, dynamic> telaLike) onUpdateCallback;
  final Future<bool> Function(int id) onDeleteCallback;

  TelaFormNotifier({
    required this.onCreateCallback,
    required this.onUpdateCallback,
    required this.onDeleteCallback,
    required Tela tela,
  }) : super(TelaFormState(
          id: tela.id,
          nombre: tela.nombre,
          precxmen: tela.precxmen != 0 ? tela.precxmen.toString() : '',
          precxmay: tela.precxmay != 0 ? tela.precxmay.toString() : '',
          precxrollo: tela.precxrollo != 0 ? tela.precxrollo.toString() : '',
          precxcompra: tela.precxcompra != 0 ? tela.precxcompra.toString() : '',
        ));

  Future<bool> onSubmit({required bool isUpdate}) async {
    if (isFormInvalid()) return false;
    final telaLike = telaToMap();
    try {
      return isUpdate
          ? await onUpdateCallback(telaLike)
          : await onCreateCallback(telaLike);
    } catch (e) {
      return false;
    }
  }

  Future<bool> onDeleteSubmit() async {    
    try {
      return await onDeleteCallback(state.id!);
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> telaToMap() {
    return {
      'id': state.id,
      'nombre': state.nombre,
      'precxmen': _tryParse(state.precxmen) ?? 0,
      'precxmay': _tryParse(state.precxmay) ?? 0,
      'precxrollo': _tryParse(state.precxrollo) ?? 0,
      'precxcompra': _tryParse(state.precxcompra) ?? 0,
    };
  }

  bool isFormInvalid() {
    return validadorVacio() || !validadorDecimal();
  }

  bool validadorVacio() {
    return state.nombre.isEmpty ||
        state.precxmen.isEmpty ||
        state.precxmay.isEmpty ||
        state.precxrollo.isEmpty ||
        state.precxcompra.isEmpty;
  }

  bool validadorDecimal() {
    return _tryParse(state.precxmen) != null &&
        _tryParse(state.precxmay) != null &&
        _tryParse(state.precxrollo) != null &&
        _tryParse(state.precxcompra) != null;
  }

  double? _tryParse(String value) {
    return double.tryParse(value);
  }

  void onNombreChanged(String value) => _updateState(nombre: value);
  void onPrecxmenChanged(String value) => _updateState(precxmen: value);
  void onPrecxmayChanged(String value) => _updateState(precxmay: value);
  void onPrecxrolloChanged(String value) => _updateState(precxrollo: value);
  void onPrecxcompraChanged(String value) => _updateState(precxcompra: value);

  void _updateState({
    String? nombre,
    String? precxmen,
    String? precxmay,
    String? precxrollo,
    String? precxcompra,
  }) {
    state = state.copyWith(
      nombre: nombre ?? state.nombre,
      precxmen: precxmen ?? state.precxmen,
      precxmay: precxmay ?? state.precxmay,
      precxrollo: precxrollo ?? state.precxrollo,
      precxcompra: precxcompra ?? state.precxcompra,
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
