import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';

final detalleVentaFormProvider = StateNotifierProvider.autoDispose
    .family<DetalleVentaFormNotifier, DetalleVentaFormState, int>(
        (ref, idventa) {
  final createCallback =
      ref.watch(detalleVentasProvider(idventa).notifier).createDetVenta;    
  return DetalleVentaFormNotifier(onSubmitCallback: createCallback);
});

class DetalleVentaFormNotifier extends StateNotifier<DetalleVentaFormState> {
  final Future<bool> Function(List<Map<String, dynamic>> detVentaLike)?
      onSubmitCallback;
  /* final Future<bool> Function(Map<String, dynamic> ventaLike, int id)?
      onUpdateCallback; */
  DetalleVentaFormNotifier({this.onSubmitCallback})
      : super(DetalleVentaFormState());

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

    final detVentaLike = {
      'idtelas': state.idtelas,
      'nombre': state.nombre,
      'cantidad': cantidad,
      'precio': state.precio,
      'total': total,
      'ganancias': ganancias,
    };

    state = state.copyWith(
      detVentas: [detVentaLike, ...state.detVentas],
      total: state.total + total,
      ganancias: state.ganancias + ganancias,
      precio: '',
      cantidad: '',
    );
  }

  int obtenerIndex(int idtelas, double cantidad, double precio) {
    return state.detVentas.indexWhere((element) =>
        element['idtelas'] == idtelas &&
        element['cantidad'] == cantidad &&
        element['precio'] == precio);
  }

  void removeDetalleVenta(int idtelas, double cantidad, double precio) {
    final index = obtenerIndex(idtelas, cantidad, precio);
    if (index == -1) return;
    final detVentaToRemove = state.detVentas[index];
    state = state.copyWith(
        total: state.total - detVentaToRemove['total'],
        ganancias: state.ganancias - detVentaToRemove['ganancias']);
    state.detVentas.removeAt(index);
  }

  Future<bool> onFormSubmit() async {
    try {
      if (onSubmitCallback == null) return false;
      if (state.detVentas.isEmpty) return false;
      if (state.descuento == '') onDescuentoChanged('0');

      return await onSubmitCallback!(state.detVentas);

    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> toJson() {
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

class DetalleVentaFormState {
  final int idtelas;
  final String nombre;
  final String cantidad;
  final String precio;
  final double precxcompra;
  final double total;
  final List<Map<String, dynamic>> detVentas;
  final String descuento;
  final double ganancias;

  DetalleVentaFormState(
      {this.idtelas = 0,
      this.precxcompra = 0,
      this.cantidad = '',
      this.precio = '',
      this.nombre = '',
      this.detVentas = const [],
      this.total = 0,
      this.descuento = '',
      this.ganancias = 0});

  DetalleVentaFormState copyWith({
    int? idtelas,
    String? cantidad,
    String? precio,
    String? nombre,
    double? total,
    List<Map<String, dynamic>>? detVentas,
    double? precxcompra,
    String? descuento,
    double? ganancias,
  }) =>
      DetalleVentaFormState(
        idtelas: idtelas ?? this.idtelas,
        cantidad: cantidad ?? this.cantidad,
        precio: precio ?? this.precio,
        detVentas: detVentas ?? this.detVentas,
        nombre: nombre ?? this.nombre,
        total: total ?? this.total,
        precxcompra: precxcompra ?? this.precxcompra,
        descuento: descuento ?? this.descuento,
        ganancias: ganancias ?? this.ganancias,
      );
}
