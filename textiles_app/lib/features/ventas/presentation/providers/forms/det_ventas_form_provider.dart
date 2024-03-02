import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:textiles_app/features/shared/infrastructure/inputs/inputs.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import 'package:textiles_app/features/ventas/presentation/providers/providers.dart';

final detalleVentaFormProvider = StateNotifierProvider.autoDispose
    .family<DetalleVentaFormNotifier, DetalleVentaFormState, DetalleVenta>(
        (ref, detalleVenta) {
  final createCallback = ref.watch(detalleVentasProvider.notifier).createDetVenta(detalleVentasLike);

  return DetalleVentaFormNotifier(
    onSubmitCallback: createCallback,
    detalleVenta: detalleVenta,
  );
});

class DetalleVentaFormNotifier extends StateNotifier<DetalleVentaFormState> {
  final Future<bool> Function(Map<String, dynamic> detVentaLike)?
      onSubmitCallback;

  DetalleVentaFormNotifier({
    this.onSubmitCallback,
    required DetalleVenta detalleVenta,
  }) : super(DetalleVentaFormState(
          idtelas: detalleVenta.idtelas,
          cantidad: detalleVenta.cantidad,
          precio: Price.dirty(detalleVenta.precio),
        ));

  Future<bool> onFormSubmit() async {
    _touchedEverything();
    if (!state.isFormValid) return false;

    if (onSubmitCallback == null) return false;

    final detVentaLike = {
      'idtelas': state.idtelas,
      'cantidad': state.cantidad,
      'precio': state.precio.value,
    };

    try {
      return await onSubmitCallback!(detVentaLike);
    } catch (e) {
      return false;
    }
  }

  void _touchedEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Price.dirty(state.precio.value),
      ]),
    );
  }

  void onPrecioChanged(double value) {
    final precio = Price.dirty(value);
    state = state.copyWith(
      precio: precio,
      isFormValid: Formz.validate([
        precio,
      ]),
    );
  }

  void onIdTelasChanged(int value) {
    state = state.copyWith(
      idtelas: value,
    );
  }

  void onCantidadChanged(double value) {
    state = state.copyWith(
      cantidad: value,
    );
  }
}

class DetalleVentaFormState {
  final bool isFormValid;
  final int idtelas;
  final double cantidad;
  final Price precio;
  DetalleVentaFormState({
    this.isFormValid = false,
    this.idtelas = 0,
    this.cantidad = 0,
    this.precio = const Price.dirty(0),
  });

  DetalleVentaFormState copyWith({
    bool? isFormValid,
    int? idtelas,
    double? cantidad,
    Price? precio,
  }) =>
      DetalleVentaFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        idtelas: idtelas ?? this.idtelas,
        cantidad: cantidad ?? this.cantidad,
        precio: precio ?? this.precio,
      );
}
