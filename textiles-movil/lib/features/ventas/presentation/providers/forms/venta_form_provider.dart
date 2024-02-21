/* import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/ventas/domain/domain.dart';
import 'package:teslo_shop/features/ventas/presentation/providers/detalleVentas_provider.dart';

final ventaFormProvider = StateNotifierProvider.autoDispose
    .family<VentaFormNotifier, VentaFormState, DetalleVenta>(
        (ref, detalleVenta) {
          final createCallback=ref.watch(detalleVentasProvider.notifier).
        });

class VentaFormNotifier extends StateNotifier<VentaFormState> {
  VentaFormNotifier(super.state);
}

class VentaFormState {
  final bool isFormValid;
  final String nombre;
  final double precio;
  final double cantidad;

  VentaFormState({
    this.isFormValid = false,
    this.nombre = '',
    this.precio = 0,
    this.cantidad = 1,
  });

  VentaFormState copyWith({
    bool? isFormValid,
    String? nombre,
    double? precio,
    double? cantidad,
  }) {
    return VentaFormState(
      isFormValid: isFormValid ?? this.isFormValid,
      nombre: nombre ?? this.nombre,
      precio: precio ?? this.precio,
      cantidad: cantidad ?? this.cantidad,
    );
  }
}
 */