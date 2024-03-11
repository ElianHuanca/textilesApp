import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';

final detalleVentaFormProvider =
    StateNotifierProvider<DetalleVentaFormNotifier, DetalleVentaFormState>(
        (ref) {
  final createCallback =
      ref.watch(detalleVentasProvider.notifier).createDetVenta;
  final idventas = ref.watch(ventaProvider).venta?.id ?? 0;
  return DetalleVentaFormNotifier(
    onSubmitCallback: createCallback,
    idventas: idventas,
  );
});

class DetalleVentaFormNotifier extends StateNotifier<DetalleVentaFormState> {
  final Future<bool> Function(List<Map<String, dynamic>> detVentaLike, int)?
      onSubmitCallback;
  final int? idventas;
  DetalleVentaFormNotifier({this.onSubmitCallback, this.idventas})
      : super(DetalleVentaFormState());

  addDetalleVenta() {
    if (state.idtelas == 0) return;
    if (double.tryParse(state.cantidad) == null) return;
    if (double.tryParse(state.precio) == null) return;

    final index = state.detVentas
        .indexWhere((element) => element['idtelas'] == state.idtelas);

    if (index != -1) {
      final detVentaToUpdate = state.detVentas[index];
      state = state.copyWith(
          total: state.total -
              double.parse(detVentaToUpdate['cantidad']) *
                  double.parse(detVentaToUpdate['precio']));
      final updatedDetVenta = {
        ...detVentaToUpdate,
        'cantidad': double.parse(state.cantidad),
        'precio': double.parse(state.precio),
        'total': double.parse(state.cantidad) * double.parse(state.precio),
      };
      state.detVentas[index] = updatedDetVenta;
    } else {
      final detVentaLike = {
        'idtelas': state.idtelas,
        'nombre': state.nombre,
        'cantidad': double.parse(state.cantidad),
        'precio': double.parse(state.precio),
        'total': double.parse(state.cantidad) * double.parse(state.precio),
      };
      state = state.copyWith(
        detVentas: [detVentaLike,...state.detVentas],
      );
    }

    state = state.copyWith(
      total: state.total +
          double.parse(state.cantidad) * double.parse(state.precio),
    );

    onPrecioChanged('');
    onCantidadChanged('');
    return;
  }

  removeDetalleVenta(int idtelas) {
    final index =
        state.detVentas.indexWhere((element) => element['idtelas'] == idtelas);
    if (index == -1) return;
    final detVentaToRemove = state.detVentas[index];
    state = state.copyWith(
        total: state.total -
            double.parse(detVentaToRemove['cantidad']) *
                double.parse(detVentaToRemove['precio']));
    state.detVentas.removeAt(index);
  }

  Future<bool> onFormSubmit() async {
    try {
      if (onSubmitCallback == null) return false;
      if (state.detVentas.isEmpty) return false;
      return await onSubmitCallback!(state.detVentas, idventas!);
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
}

class DetalleVentaFormState {
  final bool isFormValid;
  final int idtelas;
  final String nombre;
  final String cantidad;
  final String precio;
  final double total;
  final List<Map<String, dynamic>> detVentas;

  DetalleVentaFormState(
      {this.isFormValid = false,
      this.idtelas = 0,
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
          TextEditingController? controller}) =>
      DetalleVentaFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        idtelas: idtelas ?? this.idtelas,
        cantidad: cantidad ?? this.cantidad,
        precio: precio ?? this.precio,
        detVentas: detVentas ?? this.detVentas,
        nombre: nombre ?? this.nombre,
        total: total ?? this.total,
      );
}
