import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

final sucursalFormProvider = StateNotifierProvider.autoDispose
    .family<SucursalFormNotifier, SucursalFormState, Sucursal>((ref, sucursal) {
  final sucursalesNotifier = ref.watch(sucursalesProvider.notifier);
  return SucursalFormNotifier(
    sucursal: sucursal,
    onCreateCallback: sucursalesNotifier.createSucursal,
    onUpdateCallback: sucursalesNotifier.updateSucursal,
    onDeleteCallback: sucursalesNotifier.deleteSucursal,
  );
});

class SucursalFormNotifier extends StateNotifier<SucursalFormState> {
  final Future<bool> Function(Map<String, dynamic>) onCreateCallback;
  final Future<bool> Function(Map<String, dynamic>) onUpdateCallback;
  final Future<bool> Function(int id) onDeleteCallback;
  SucursalFormNotifier({
    required this.onCreateCallback,
    required this.onUpdateCallback,
    required this.onDeleteCallback,
    required Sucursal sucursal,
  }) : super(SucursalFormState(
          id: sucursal.id,
          nombre: sucursal.nombre,
        ));

  Future<bool> onSubmit({required bool isUpdate}) async {
    if (isFormInvalid()) return false;
    final sucursalLike = toMap();
    try {
      return isUpdate
          ? await onUpdateCallback(sucursalLike)
          : await onCreateCallback(sucursalLike);
    } catch (e) {
      return false;
    }
  }

  bool isFormInvalid() {
    return state.nombre.isEmpty;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': state.id,
      'nombre': state.nombre,
    };
  }

  Future<bool> onDelete() async {
    try {
      return await onDeleteCallback(state.id);
    } catch (e) {
      return false;
    }
  }

  onNombreChanged(String value) {
    state = state.copyWith(
      nombre: value,
    );
  }
}

class SucursalFormState {
  final int id;
  final String nombre;

  SucursalFormState({this.id = 0, this.nombre = ''});

  SucursalFormState copyWith({
    bool? isFormValid,
    int? id,
    String? nombre,
  }) =>
      SucursalFormState(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );
}
