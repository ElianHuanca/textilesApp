import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

final sucursalFormProvider = StateNotifierProvider.autoDispose
    .family<SucursalFormNotifier, SucursalFormState, Sucursal>((ref, sucursal) {
  final createCallback =ref.watch(sucursalesProvider.notifier).createSucursal;
  final updateCallback = ref.watch(sucursalesProvider.notifier).updateSucursal;
  final deleteCallback = ref.watch(sucursalesProvider.notifier).deleteSucursal;  
  return SucursalFormNotifier(
    sucursal: sucursal,
    onCreateCallback: createCallback,
    onUpdateCallback: updateCallback,
    onDeleteCallback: deleteCallback,    
  );
});
class SucursalFormNotifier extends StateNotifier<SucursalFormState> {
  final Future<bool> Function(Map<String, dynamic>)?onCreateCallback;
  final Future<bool> Function(Map<String, dynamic>)? onUpdateCallback;
  final Future<bool> Function(int id)? onDeleteCallback;  
  SucursalFormNotifier({
    this.onCreateCallback,
    this.onUpdateCallback,
    this.onDeleteCallback,
    required Sucursal sucursal,
    
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
    return state.nombre.isEmpty;      
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
