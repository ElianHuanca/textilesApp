/* import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import '../../providers/providers.dart';

final ventaFormProvider = StateNotifierProvider.autoDispose
    .family<VentaFormNotifier, VentaFormState, Venta>((ref, venta) {
  final createCallback =
      ref.watch(ventasProvider(venta.idsucursales).notifier).actualizarVenta;
  return VentaFormNotifier(onSubmitCallback: createCallback,id:venta.id);
});

class VentaFormNotifier extends StateNotifier<VentaFormState> {
  final Future<bool> Function(Map<String, dynamic> ventaLike, int id)?
      onSubmitCallback;
  VentaFormNotifier({this.onSubmitCallback,required int id}) : super(VentaFormState(
      id: id,
      idtelas: 0,
      precxcompra: 0,
      cantidad: '',
      precio: '',
      nombre: '',
      total: 0,
      descuento: '',
      ganancias: 0
  ));

  void addDetalleVenta() {
    if (state.idtelas == 0) return;
    if (double.tryParse(state.cantidad) == null) return;
    final double cantidad = double.parse(state.cantidad);
    if (cantidad <= 0) return;
    if (double.tryParse(state.precio) == null) return;
    final double precio = double.parse(state.precio);
    if (precio <= 0) return;

    final double ganancias = state.precxcompra == 0
        ? 0
        : (((precio - state.precxcompra) * cantidad) * 100).round() / 100.0;

    final double total = (cantidad * precio * 100).round() / 100.0;

    state = state.copyWith(
      total: state.total + total,
      ganancias: state.ganancias + ganancias,
      precio: '',
      cantidad: '',
    );
  }

  Future<bool> onFormSubmit() async {
    try {
      if (onSubmitCallback == null) return false;
      if (state.descuento == '') onDescuentoChanged('0');

      final venta = ventaToMap();
      return await onSubmitCallback!(venta, state.id);
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> ventaToMap() {
    return {
      'total': state.total,
      'descuento': state.descuento,
      'ganancias': state.ganancias,
    };
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

  void onPrecxCompraChanged(double value) {
    state = state.copyWith(
      precxcompra: value,
    );
  }

  void onDescuentoChanged(String value) {
    state = state.copyWith(
      descuento: value,
    );
  }
}

class VentaFormState {
  final int id;
  final int idtelas;
  final String nombre;
  final String cantidad;
  final String precio;
  final double precxcompra;
  final double total;
  final String descuento;
  final double ganancias;

  VentaFormState(
      {
      this.id = 0,
      this.idtelas = 0,
      this.precxcompra = 0,
      this.cantidad = '',
      this.precio = '',
      this.nombre = '',
      this.total = 0,
      this.descuento = '',
      this.ganancias = 0});

  VentaFormState copyWith({
    int? id,
    int? idtelas,
    String? cantidad,
    String? precio,
    String? nombre,
    double? total,
    double? precxcompra,
    String? descuento,
    double? ganancias,
  }) =>
      VentaFormState(
        id: id ?? this.id,
        idtelas: idtelas ?? this.idtelas,
        cantidad: cantidad ?? this.cantidad,
        precio: precio ?? this.precio,
        nombre: nombre ?? this.nombre,
        total: total ?? this.total,
        precxcompra: precxcompra ?? this.precxcompra,
        descuento: descuento ?? this.descuento,
        ganancias: ganancias ?? this.ganancias,
      );
}
 */