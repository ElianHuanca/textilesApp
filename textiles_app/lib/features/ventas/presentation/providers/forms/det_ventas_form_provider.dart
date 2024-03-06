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
    _touchedEverything();
    if (!state.isFormValid) return;

    //if (onSubmitCallback == null) return false;

    if (state.idtelas == 0) return;
    if (state.cantidad.value <= 0) return;
    if (state.precio.value <= 0) return;

    final index = state.detVentas
        .indexWhere((element) => element['idtelas'] == state.idtelas);

    if (index != -1) {
      // Si el idtelas está en la lista, reemplazar cantidad, precio y total
      final detVentaToUpdate = state.detVentas[index];
      state = state.copyWith(
        total: state.total - detVentaToUpdate['cantidad'] * detVentaToUpdate['precio'],
      );
      final updatedDetVenta = {
        ...detVentaToUpdate,
        'cantidad': state.cantidad.value,
        'precio': state.precio.value,
        'total': state.cantidad.value * state.precio.value,
      };
      // Reemplazar el elemento en la lista
      state.detVentas[index] = updatedDetVenta;
    } else {
      // Si el idtelas no está en la lista, agregar un nuevo elemento
      final detVentaLike = {
        'idtelas': state.idtelas,
        'nombre': state.nombre,
        'cantidad': state.cantidad.value,
        'precio': state.precio.value,
        'total': state.cantidad.value * state.precio.value,
      };
      state = state.copyWith(
        detVentas: [...state.detVentas, detVentaLike],        
      );
    }

    state = state.copyWith(
      total: state.total + state.cantidad.value * state.precio.value,
      //idtelas: 0,
      //nombre: '',
      cantidad: const Price.dirty(0),
      precio: const Price.dirty(0),
    );

    return;
  }

  Future<bool> onFormSubmit() async {
    try {
      return await onSubmitCallback!(state.detVentas);
    } catch (e) {
      return false;
    }
  }

  void _touchedEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Price.dirty(state.precio.value),
        Price.dirty(state.cantidad.value),
      ]),
    );
  }

  void onPrecioChanged(double value) {
    final precio = Price.dirty(value);
    state = state.copyWith(
      precio: precio,
      isFormValid: Formz.validate([
        precio,
        Price.dirty(state.cantidad.value),
      ]),
    );
  }

  void onIdTelasChanged(int value) {
    state = state.copyWith(
      idtelas: value,
    );
  }

  void onCantidadChanged(double value) {
    final cantidad = Price.dirty(value);
    state = state.copyWith(
        cantidad: cantidad,
        isFormValid: Formz.validate([
          cantidad,
          Price.dirty(state.precio.value),
        ]));
  }

  void onNombreChanged(String value) {
    state = state.copyWith(
      nombre: value,
    );
  }
}

class DetalleVentaFormState {
  final bool isFormValid;
  final int idtelas;
  final String nombre;
  final Price cantidad;
  final Price precio;
  final double total;
  final List<Map<String, dynamic>> detVentas;

  DetalleVentaFormState({
    this.isFormValid = false,
    this.idtelas = 0,
    this.cantidad = const Price.dirty(0),
    this.precio = const Price.dirty(0),
    this.nombre = '',
    this.detVentas = const [],
    this.total = 0,
  });

  DetalleVentaFormState copyWith({
    bool? isFormValid,
    int? idtelas,
    Price? cantidad,
    Price? precio,
    String? nombre,
    double? total,
    List<Map<String, dynamic>>? detVentas,
  }) =>
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
