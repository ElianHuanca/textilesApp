import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:textiles_app/features/shared/shared.dart';
import '../../../domain/domain.dart';
import '../providers.dart';


final telaFormProvider = StateNotifierProvider.autoDispose.family<TelaFormNotifier, TelaFormState, Tela>(
  (ref, tela) {

    final createUpdateCallback = ref.watch( telasProvider.notifier ).createOrUpdateTela;
    final deleteCallback = ref.watch( telasProvider.notifier ).deleteTela;
    return TelaFormNotifier(
      tela: tela,
      onSubmitCallback: createUpdateCallback,
      onDeleteCallback: deleteCallback,
    );
  }
);





class  TelaFormNotifier extends StateNotifier<TelaFormState> {

  final Future<bool> Function( Map<String,dynamic> telaLike )? onSubmitCallback;
  final Future<bool> Function( int id )? onDeleteCallback;
   TelaFormNotifier({
    this.onSubmitCallback,
    required Tela tela,
    this.onDeleteCallback,
  }): super(
    TelaFormState(
      id: tela.id,
      nombre: Title.dirty(tela.nombre),      
      precxmen: Price.dirty(tela.precxmen!),
      precxmay: Price.dirty(tela.precxmay!),
      precxrollo: Price.dirty(tela.precxrollo!),
      precxcompra: Price.dirty(tela.precxcompra!),
    )
  );

  Future<bool> onFormSubmit() async {
    _touchedEverything();
    if ( !state.isFormValid ) return false;

    // TODO: regresar
    if ( onSubmitCallback == null ) return false;

    final telaLike = {
      'id' : state.id,
      'nombre': state.nombre.value,      
      'precxmen': state.precxmen.value,
      'precxmay': state.precxmay.value,
      'precxrollo': state.precxrollo.value,
      'precxcompra': state.precxcompra.value,
    };

    try {
      return await onSubmitCallback!( telaLike );
    } catch (e) {
      return false;
    }

  }

  Future<bool> onFormDelete() async {
    if (onDeleteCallback == null) return false;

    try {
      return await onDeleteCallback!(state.id!);
    } catch (e) {
      return false;
    }
  }


  void _touchedEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Title.dirty(state.nombre.value),
        Price.dirty(state.precxmen.value),
        Price.dirty(state.precxmay.value),
        Price.dirty(state.precxrollo.value),
        Price.dirty(state.precxcompra.value),
      ]),
    );
  }


  void onNombreChanged( String value ) {
    state = state.copyWith(
      nombre: Title.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(value),        
        Price.dirty(state.precxmen.value),
        Price.dirty(state.precxmay.value),
        Price.dirty(state.precxrollo.value),
        Price.dirty(state.precxcompra.value),
      ])
    );
  }

  void onPrecxmenChanged( double value ) {
    state = state.copyWith(
      precxmen: Price.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.nombre.value),        
        Price.dirty(value),
        Price.dirty(state.precxmay.value),
        Price.dirty(state.precxrollo.value),
        Price.dirty(state.precxcompra.value),
      ])
    );
  }

  void onPrecxmayChanged( double value ) {
    state = state.copyWith(
      precxmay: Price.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.nombre.value),        
        Price.dirty(state.precxmen.value),
        Price.dirty(value),
        Price.dirty(state.precxrollo.value),
        Price.dirty(state.precxcompra.value),
      ])
    );
  }

  void onPrecxrolloChanged( double value ) {
    state = state.copyWith(
      precxrollo: Price.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.nombre.value),        
        Price.dirty(state.precxmen.value),
        Price.dirty(state.precxmay.value),
        Price.dirty(value),
        Price.dirty(state.precxcompra.value),
      ])
    );
  }

  void onPrecxcompraChanged( double value ) {
    state = state.copyWith(
      precxcompra: Price.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.nombre.value),        
        Price.dirty(state.precxmen.value),
        Price.dirty(state.precxmay.value),
        Price.dirty(state.precxrollo.value),
        Price.dirty(value),
      ])
    );
  }
}





class TelaFormState {

  final bool isFormValid;
  final int? id;
  final Title nombre;  
  final Price precxmen;
  final Price precxmay;
  final Price precxrollo;
  final Price precxcompra;

  TelaFormState({
    this.isFormValid = false, 
    this.id, 
    this.nombre = const Title.dirty(''),     
    this.precxmen = const Price.dirty(0),
    this.precxmay = const Price.dirty(0),
    this.precxrollo = const Price.dirty(0),
    this.precxcompra = const Price.dirty(0),
  });

  TelaFormState copyWith({
    bool? isFormValid,
    int? id,
    Title? nombre,
    Price? precxmen,
    Price? precxmay,
    Price? precxrollo,
    Price? precxcompra,
    
  }) => TelaFormState(
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    precxmen: precxmen ?? this.precxmen,
    precxmay: precxmay ?? this.precxmay,
    precxrollo: precxrollo ?? this.precxrollo,
    precxcompra: precxcompra ?? this.precxcompra,
  );


}