import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';

final detalleVentaFormProvider =
    StateNotifierProvider<DetalleVentaFormNotifier, DetalleVentaFormState>(
        (ref) {
  final createCallback =
      ref.watch(detalleVentasProvider.notifier).createDetVenta;

  return DetalleVentaFormNotifier(onSubmitCallback: createCallback);
});

class DetalleVentaFormNotifier extends StateNotifier<DetalleVentaFormState> {
  final Future<bool> Function(List<Map<String, dynamic>> detVentaLike)?
      onSubmitCallback;

  DetalleVentaFormNotifier({this.onSubmitCallback})
      : super(DetalleVentaFormState());

  addDetalleVenta() {
    if (state.idtelas == 0) return;
    if (double.tryParse(state.cantidad) == null) return;
    if (double.tryParse(state.precio) == null) return;
    if (double.parse(state.precio) <= 0) return;
    if (double.parse(state.precio) < state.precxcompra) return;

    final ganancias = state.precxcompra == 0
        ? 0
        : (double.parse(state.precio) - state.precxcompra)*double.parse(state.cantidad);

    final detVentaLike = {
      'idtelas': state.idtelas,
      'nombre': state.nombre,
      'cantidad': double.parse(state.cantidad),
      'precio': double.parse(state.precio),
      'total': double.parse(state.cantidad) * double.parse(state.precio),
      'ganancias': ganancias
    };

    state = state.copyWith(
      detVentas: [detVentaLike, ...state.detVentas],
      total: state.total +
          double.parse(state.cantidad) * double.parse(state.precio),      
      precio: '',
      cantidad: '',
    );
    return;
  }

  removeDetalleVenta(int idtelas) {
    final index =
        state.detVentas.indexWhere((element) => element['idtelas'] == idtelas);
    if (index == -1) return;
    final detVentaToRemove = state.detVentas[index];
    state = state.copyWith(
        total: state.total - detVentaToRemove['cantidad'] * detVentaToRemove['precio']);
        
    state.detVentas.removeAt(index);
  }

  Future<bool> onFormSubmit() async {
    try {
      if (onSubmitCallback == null) return false;
      if (state.detVentas.isEmpty) return false;
      return await onSubmitCallback!(state.detVentas);
    } catch (e) {
      return false;
    }
  }

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

  void onGananciasChanged(double value) {
    state = state.copyWith(
      ganancias: value,
    );
  }

  void onPrecxCompraChanged(double value) {
    state = state.copyWith(
      precxcompra: value,
    );
  }
}

class DetalleVentaFormState {
  final bool isFormValid;
  final int idtelas;
  final String nombre;
  final double precxcompra;
  final String cantidad;
  final String precio;
  final double total;
  final double ganancias;
  final List<Map<String, dynamic>> detVentas;

  DetalleVentaFormState(
      {this.isFormValid = false,
      this.idtelas = 0,
      this.precxcompra = 0,
      this.ganancias = 0,
      this.cantidad = '',
      this.precio = '',
      this.nombre = '',
      this.detVentas = const [],
      this.total = 0});

  DetalleVentaFormState copyWith(
          {bool? isFormValid,
          int? idtelas,
          String? cantidad,
          String? precio,
          String? nombre,
          double? total,
          List<Map<String, dynamic>>? detVentas,
          double? ganancias,
          double? precxcompra,
          TextEditingController? controller}) =>
      DetalleVentaFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        idtelas: idtelas ?? this.idtelas,
        cantidad: cantidad ?? this.cantidad,
        precio: precio ?? this.precio,
        detVentas: detVentas ?? this.detVentas,
        nombre: nombre ?? this.nombre,
        total: total ?? this.total,
        ganancias: ganancias ?? this.ganancias,
        precxcompra: precxcompra ?? this.precxcompra,
      );
}
