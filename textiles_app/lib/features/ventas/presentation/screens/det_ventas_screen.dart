import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/shared/shared.dart';
import '../providers/providers.dart';

/* class DetVentas extends ConsumerWidget {
  const DetVentas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detalleVentasState = ref.watch(detalleVentasProvider);
    final venta = ref.watch(ventaProvider).venta;
    final String title = 'Ventas ${venta?.fecha}';
    final String subtitle =
        'Total: ${venta?.total}Bs Ganancias: ${venta?.ganancias}Bs';
    return Screen2(
        title: title,
        subtitle: subtitle,
        dataTable: dataTableWidget(context,detalleVentasState.detalleVentas));
  }  
} */

class DetVentas extends ConsumerWidget {
  const DetVentas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detalleVentasState = ref.watch(detalleVentasProvider);
    final venta = ref.watch(ventaProvider).venta;
    final List<Map<String, dynamic>> detalleVentas = detalleVentasState
        .detalleVentas
        .map((detalleVenta) => detalleVenta.toJson() as Map<String, dynamic>)
        .toList();
    DateTime date = DateTime.parse(venta!.fecha);
    String fecha = "${date.day}-${date.month}-${date.year}";
    return Screen1(
        widget: [dataTableMap(context, detalleVentas, venta.total)],
        title: fecha,
        isGridview: false);
  }
}
