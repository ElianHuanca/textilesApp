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
  final Future<bool> Function(
          List<Map<String, dynamic>> detVentaLike, double descuento)?
      onSubmitCallback;

  DetalleVentaFormNotifier({this.onSubmitCallback})
      : super(DetalleVentaFormState());

  void addDetalleVenta() {
    if (state.idtelas == 0) return;    
    if (double.tryParse(state.cantidad) == null) return;
    if (double.tryParse(state.precio) == null) return;
    if (double.parse(state.precio) <= 0) return;

    final double ganancias = state.precxcompra == 0
        ? 0
        : (double.parse(state.precio) - state.precxcompra) *
            double.parse(state.cantidad);

    
    final detVentaLike = {
      'idtelas': state.idtelas,
      'nombre': state.nombre,
      'cantidad': double.parse(state.cantidad),
      'precio': double.parse(state.precio),
      'total': (double.parse(state.cantidad) * double.parse(state.precio)*100).round()/100.0,
      'ganancias': (ganancias*100).round()/100.0,
    };

    state = state.copyWith(
      detVentas: [detVentaLike, ...state.detVentas],
      total: state.total +
          double.parse(state.cantidad) * double.parse(state.precio),
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
        total: state.total -
            detVentaToRemove['cantidad'] * detVentaToRemove['precio']);
    state.detVentas.removeAt(index);
  }

  Future<bool> onFormSubmit() async {
    try {      
      if (onSubmitCallback == null) return false;      
      if (state.detVentas.isEmpty) return false; 
      //if (double.tryParse(state.descuento)== null) return false;
      if (state.descuento == '') onDescuentoChanged('0');
                             
      return await onSubmitCallback!(state.detVentas, double.parse(state.descuento));      
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
  //final double ganancias;

  DetalleVentaFormState(
      {
      this.idtelas = 0,
      this.precxcompra = 0,
      this.cantidad = '',
      this.precio = '',
      this.nombre = '',
      this.detVentas = const [],
      this.total = 0,
      this.descuento = '',
      //this.ganancias = 0
      });

  DetalleVentaFormState copyWith({    
    int? idtelas,
    String? cantidad,
    String? precio,
    String? nombre,
    double? total,
    List<Map<String, dynamic>>? detVentas,
    double? precxcompra,
    String? descuento,
    //double? ganancias,
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
        //ganancias: ganancias ?? this.ganancias,
      );
}
