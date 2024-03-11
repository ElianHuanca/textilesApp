import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

final sucursalFormProvider = StateNotifierProvider.autoDispose
    .family<SucursalFormNotifier, SucursalFormState, Sucursal>((ref, sucursal) {
  final createCallback =ref.watch(sucursalesProvider.notifier).createSucursal;
  final updateCallback = ref.watch(sucursalesProvider.notifier).updateSucursal;
  final deleteCallback = ref.watch(sucursalesProvider.notifier).deleteSucursal;
  //final int idusuarios = ref.watch(authProvider).usuario!.id;
  return SucursalFormNotifier(
    sucursal: sucursal,
    onCreateCallback: createCallback,
    onUpdateCallback: updateCallback,
    onDeleteCallback: deleteCallback,
    //idusuarios: idusuarios,
  );
});
class SucursalFormNotifier extends StateNotifier<SucursalFormState> {
  final Future<bool> Function(Map<String, dynamic>)?onCreateCallback;
  final Future<bool> Function(Map<String, dynamic>)? onUpdateCallback;
  final Future<bool> Function(int id)? onDeleteCallback;
  //final int idusuarios;
  SucursalFormNotifier({
    this.onCreateCallback,
    this.onUpdateCallback,
    this.onDeleteCallback,
    required Sucursal sucursal,
    //required this.idusuarios,
  }) : super(SucursalFormState(
          id: sucursal.id,
          nombre: sucursal.nombre,
        ));

  Future<bool> onFormCreate() async {
    if (onCreateCallback == null) return false;    
    if(validador()) return false;
    final sucursalLike = stateToMap();
    try {
      return await onCreateCallback!(sucursalLike);
    } catch (e) {
      return false;
    }
  }

  bool validador() {
    return state.nombre == '' ? true : false;      
  }

  Map<String, dynamic> stateToMap() {
    return {
      'id': state.id,
      'nombre': state.nombre,
    };
  }
  Future<bool> onFormUpdate() async{
    if (onUpdateCallback == null) return false;
    if(validador()) return false;
    final sucursalLike = stateToMap();
    try {
      return await onUpdateCallback!(sucursalLike);
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
      onCreateCallback;
  final Future<bool> Function(int id)? onDeleteCallback;
  final int idusuarios;
  SucursalFormNotifier({
    this.onCreateCallback,
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
    if (onCreateCallback == null) return false;

    final sucursalLike = {
      'id': state.id,
      'nombre': state.nombre.value,
    };

    try {
      return await onCreateCallback!(sucursalLike, idusuarios);
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
