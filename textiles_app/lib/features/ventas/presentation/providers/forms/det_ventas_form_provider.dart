import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import '../../providers/providers.dart';

final detalleVentaFormProvider = StateNotifierProvider.autoDispose
    .family<DetalleVentaFormNotifier, DetalleVentaFormState, Venta>(
        (ref, venta) {
  final createCallback =
      ref.watch(detalleVentasProvider(venta.id).notifier).createDetVenta;
  final updateCallback =
      ref.watch(ventaProvider(venta.id).notifier).actualizarVenta;
  return DetalleVentaFormNotifier(
      onSubmitCallback: createCallback,
      onUpdateCallback: updateCallback,
      idventa: venta.id);
});

class DetalleVentaFormNotifier extends StateNotifier<DetalleVentaFormState> {
  final Future<bool> Function(List<Map<String, dynamic>> detVentaLike)
      onSubmitCallback;
  final Future<bool> Function(Map<String, dynamic> ventaLike)
      onUpdateCallback;
  DetalleVentaFormNotifier(
      {required this.onSubmitCallback,
      required this.onUpdateCallback,
      required int idventa})
      : super(DetalleVentaFormState(
          idventa: idventa,
        ));

  bool _isValidDouble(String value) => double.tryParse(value) != null;

  double _toDouble(String value) => double.tryParse(value)!;

  void addDetalleVenta() {
    if (state.idtelas == 0 ||
        !_isValidDouble(state.cantidad) ||
        !_isValidDouble(state.precio)) return;

    final double cantidad = _toDouble(state.cantidad);
    final double precio = _toDouble(state.precio);
    final double precxcompra = state.precxcompra;

    if (cantidad <= 0 || precio <= 0) return;

    final double ganancias = precxcompra == 0
        ? 0
        : (((precio - precxcompra) * cantidad) * 100).round() / 100.0;

    final double total = (cantidad * precio * 100).round() / 100.0;

    final detVentaLike = {
      'idtelas': state.idtelas,
      'nombre': state.nombre,
      'cantidad': cantidad,
      'precio': precio,
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

    final detVentas = List<Map<String, dynamic>>.from(state.detVentas);
    final detVentaToRemove = detVentas.removeAt(index);
    state = state.copyWith(
        detVentas: detVentas,
        total: state.total - detVentaToRemove['total'],
        ganancias: state.ganancias - detVentaToRemove['ganancias']);
  }

  Future<bool> onFormSubmit() async {
    try {
      if (state.detVentas.isEmpty) return false;
      if (state.descuento == '') onDescuentoChanged('0');
      if (!_isValidDouble(state.descuento)) return false;
      bool value1 = await onSubmitCallback(state.detVentas);
      bool value2 = await onUpdateCallback(toMap());
      return  value1 && value2;
    } catch (e) {
      print("Error al crear detalle venta: $e");
      return false;
    }
  }

  Map<String, dynamic> toMap() {    
    return {
      'total': state.total,
      'descuento': _toDouble(state.descuento),
      'ganancias': state.ganancias,
    };
  }

  void onIdTelasChanged(int value) => _updateState(idtelas: value);
  void onNombreChanged(String value) => _updateState(nombre: value);
  void onPrecioChanged(String value) => _updateState(precio: value);
  void onCantidadChanged(String value) => _updateState(cantidad: value);
  void onPrecxCompraChanged(double value) => _updateState(precxcompra: value);
  void onDescuentoChanged(String value) => _updateState(descuento: value);

  void _updateState({
    int? idtelas,
    String? nombre,
    String? cantidad,
    String? precio,
    double? total,
    List<Map<String, dynamic>>? detVentas,
    double? precxcompra,
    String? descuento,
    double? ganancias,
  }) {
    state = state.copyWith(
      idtelas: idtelas ?? state.idtelas,
      nombre: nombre ?? state.nombre,
      cantidad: cantidad ?? state.cantidad,
      precio: precio ?? state.precio,
      total: total ?? state.total,
      detVentas: detVentas ?? state.detVentas,
      precxcompra: precxcompra ?? state.precxcompra,
      descuento: descuento ?? state.descuento,
      ganancias: ganancias ?? state.ganancias,
    );
  }
}

class DetalleVentaFormState {
  final int idventa;
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
      {this.idventa = 0,
      this.idtelas = 0,
      this.precxcompra = 0,
      this.cantidad = '',
      this.precio = '',
      this.nombre = '',
      this.detVentas = const [],
      this.total = 0,
      this.descuento = '',
      this.ganancias = 0});

  DetalleVentaFormState copyWith({
    int? idventa,
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
        idventa: idventa ?? this.idventa,
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
