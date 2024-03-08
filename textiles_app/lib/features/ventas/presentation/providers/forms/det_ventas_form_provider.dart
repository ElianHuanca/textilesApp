import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:textiles_app/features/shared/infrastructure/inputs/inputs.dart';
//import '../../providers/providers.dart';

final detalleVentaFormProvider =
    StateNotifierProvider<DetalleVentaFormNotifier, DetalleVentaFormState>(
        (ref) {
  /* final createCallback =
      ref.watch(detalleVentasProvider.notifier).createDetVenta; */

  return DetalleVentaFormNotifier(
      //onSubmitCallback: createCallback,
      );
});

class DetalleVentaFormNotifier extends StateNotifier<DetalleVentaFormState> {
  final Future<bool> Function(List<Map<String, dynamic>> detVentaLike)?
      onSubmitCallback;

  DetalleVentaFormNotifier({
    this.onSubmitCallback,
  }) : super(DetalleVentaFormState());

  addDetalleVenta() {
    //_touchedEverything();
    //if (!state.isFormValid) return;

    //if (onSubmitCallback == null) return false;

    if (state.idtelas == 0) return;
    if (double.parse(state.cantidad) <= 0) return;
    if (double.parse(state.precio) <= 0) return;

    final index = state.detVentas
        .indexWhere((element) => element['idtelas'] == state.idtelas);

    if (index != -1) {
      // Si el idtelas está en la lista, reemplazar cantidad, precio y total
      final detVentaToUpdate = state.detVentas[index];
      state = state.copyWith(
        total: state.total -
            detVentaToUpdate['cantidad'] * detVentaToUpdate['precio'],
      );
      final updatedDetVenta = {
        ...detVentaToUpdate,
        'cantidad': double.parse(state.cantidad),
        'precio': double.parse(state.precio),
        'total': double.parse(state.cantidad) * double.parse(state.precio),
      };
      // Reemplazar el elemento en la lista
      state.detVentas[index] = updatedDetVenta;
    } else {
      // Si el idtelas no está en la lista, agregar un nuevo elemento
      final detVentaLike = {
        'idtelas': state.idtelas,
        'nombre': state.nombre,
        'cantidad': double.parse(state.cantidad),
        'precio': double.parse(state.precio),
        'total': double.parse(state.cantidad) * double.parse(state.precio),
      };
      state = state.copyWith(
        detVentas: [...state.detVentas, detVentaLike],
      );
    }

    state = state.copyWith(
      total: state.total + double.parse(state.cantidad) * double.parse(state.precio),      
    );

    /* onPrecioChanged(0);
    onCantidadChanged(0); */
    return;
  }

  Future<bool> onFormSubmit() async {
    try {
      return await onSubmitCallback!(state.detVentas);
    } catch (e) {
      return false;
    }
  }

  /* void _touchedEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        String.dirty(state.precio),
        String.dirty(state.cantidad),
      ]),
    );
  }

  void onPrecioChanged(double value) {
    final precio = String.dirty(value);
    state = state.copyWith(
      precio: precio,
      isFormValid: Formz.validate([
        precio,
        String.dirty(state.cantidad),
      ]),
    );
  } 
  
  void onCantidadChanged(double value) {
    final cantidad = String.dirty(value);
    state = state.copyWith(
        cantidad: cantidad,
        isFormValid: Formz.validate([
          cantidad,
          String.dirty(state.precio),
        ]));
  }
  */

  void onIdTelasChanged(int value) {
    state = state.copyWith(
      idtelas: value,
    );
  }  

  void onNombreChanged(String value) {
    state = state.copyWith(
      nombre: value,
    );
  }

  void onPrecioChanged(String value) {
    state = state.copyWith(
      precio: value,
    );
  }

  void onCantidadChanged(String value) {
    state = state.copyWith(
      cantidad: value,
    );
  }
  /* void onControllerValueChange(String value) {
    state = state.copyWith(
      controller: TextEditingController(text: value),
    );
  }

  void onControllerDispose() {
    state.controller?.dispose();
  }

  void onControllerInit(TextEditingController controller) {
    state = state.copyWith(controller: controller);
  } */
}

class DetalleVentaFormState {
  final bool isFormValid;
  final int idtelas;
  final String nombre;
  final String cantidad;
  final String precio;
  final double total;
  final List<Map<String, dynamic>> detVentas;
  //final TextEditingController? controller;

  DetalleVentaFormState(
      {this.isFormValid = false,
      this.idtelas = 0,
      this.cantidad = '',
      this.precio = '',
      this.nombre = '',
      this.detVentas = const [],
      this.total = 0,
      //this.controller
  });

  DetalleVentaFormState copyWith(
          {bool? isFormValid,
          int? idtelas,
          String? cantidad,
          String? precio,
          String? nombre,
          double? total,
          List<Map<String, dynamic>>? detVentas,
          TextEditingController? controller}) =>
      DetalleVentaFormState(
          isFormValid: isFormValid ?? this.isFormValid,
          idtelas: idtelas ?? this.idtelas,
          cantidad: cantidad ?? this.cantidad,
          precio: precio ?? this.precio,
          detVentas: detVentas ?? this.detVentas,
          nombre: nombre ?? this.nombre,
          total: total ?? this.total,
          //controller: controller ?? this.controller
      );
}
