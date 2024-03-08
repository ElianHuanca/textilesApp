import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:formz/formz.dart';
import 'package:textiles_app/features/auth/presentation/providers/auth_provider.dart';
//import 'package:textiles_app/features/shared/shared.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

final sucursalFormProvider = StateNotifierProvider.autoDispose
    .family<SucursalFormNotifier, SucursalFormState, Sucursal>((ref, sucursal) {
  final createUpdateCallback =
      ref.watch(sucursalesProvider.notifier).createOrUpdateSucursal;
  final deleteCallback = ref.watch(sucursalesProvider.notifier).deleteSucursal;
  final int idusuarios = ref.watch(authProvider).usuario!.id;
  return SucursalFormNotifier(
    sucursal: sucursal,
    onSubmitCallback: createUpdateCallback,
    onDeleteCallback: deleteCallback,
    idusuarios: idusuarios,
  );
});
class SucursalFormNotifier extends StateNotifier<SucursalFormState> {
  final Future<bool> Function(Map<String, dynamic>,int)?
      onSubmitCallback;
  final Future<bool> Function(int id)? onDeleteCallback;
  final int idusuarios;
  SucursalFormNotifier({
    this.onSubmitCallback,
    this.onDeleteCallback,
    required Sucursal sucursal,
    required this.idusuarios,
  }) : super(SucursalFormState(
          id: sucursal.id,
          nombre: sucursal.nombre,
        ));

  Future<bool> onFormSubmit() async {

    // TODO: regresar
    if (onSubmitCallback == null) return false;

    final sucursalLike = {
      'id': state.id,
      'nombre': state.nombre,
    };

    try {
      return await onSubmitCallback!(sucursalLike, idusuarios);
    } catch (e) {
      return false;
    }
  }

  Future<bool> onFormDelete() async {
    if (onDeleteCallback == null) return false;

    try {
      return await onDeleteCallback!(state.id);
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

  SucursalFormState({    
    this.id = 0,
    this.nombre =''
  });

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


/* class SucursalFormNotifier extends StateNotifier<SucursalFormState> {
  final Future<bool> Function(Map<String, dynamic>,int)?
      onSubmitCallback;
  final Future<bool> Function(int id)? onDeleteCallback;
  final int idusuarios;
  SucursalFormNotifier({
    this.onSubmitCallback,
    this.onDeleteCallback,
    required Sucursal sucursal,
    required this.idusuarios,
  }) : super(SucursalFormState(
          id: sucursal.id,
          nombre: Title.dirty(sucursal.nombre),
        ));

  Future<bool> onFormSubmit() async {
    _touchedEverything();
    if (!state.isFormValid) return false;

    // TODO: regresar
    if (onSubmitCallback == null) return false;

    final sucursalLike = {
      'id': state.id,
      'nombre': state.nombre.value,
    };

    try {
      return await onSubmitCallback!(sucursalLike, idusuarios);
    } catch (e) {
      return false;
    }
  }

  Future<bool> onFormDelete() async {
    if (onDeleteCallback == null) return false;

    try {
      return await onDeleteCallback!(state.id);
    } catch (e) {
      return false;
    }
  }

  void _touchedEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Title.dirty(state.nombre.value),
      ]),
    );
  }

  void onNombreChanged(String value) {
    state = state.copyWith(
        nombre: Title.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(value),
        ]));
  }
}

class SucursalFormState {
  final bool isFormValid;
  final int id;
  final Title nombre;

  SucursalFormState({
    this.isFormValid = false,
    this.id = 0,
    this.nombre = const Title.dirty(''),
  });

  SucursalFormState copyWith({
    bool? isFormValid,
    int? id,
    Title? nombre,
  }) =>
      SucursalFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );
} */
