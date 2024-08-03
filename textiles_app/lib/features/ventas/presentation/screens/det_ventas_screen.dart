import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:textiles_app/features/shared/shared.dart';
import '../providers/providers.dart';

class DetVentas extends ConsumerWidget {
  final int idventa;
  const DetVentas({super.key, required this.idventa});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detalleVentasState = ref.watch(detalleVentasProvider(idventa));
    final ventaState = ref.watch(ventaProvider(idventa));
    /* final List<Map<String, dynamic>> detalleVentas = detalleVentasState
        .detalleVentas
        .map((detalleVenta) => detalleVenta.toJson() as Map<String, dynamic>)
        .toList(); */
    //String fecha = changeFormatDate(venta!.fecha);
    return detalleVentasState.isLoading || ventaState.isLoading
        ? const FullScreenLoader()
        : Screen1(
            widget: [
              container(
                  context,
                  DataTableMap(
                      list: detalleVentasState.detalleVentas,
                      total: ventaState.venta!.total,
                      ganancias: ventaState.venta!.ganancias,
                      descuento: ventaState.venta!.descuento,
                      detventas: true))
            ],
            title: changeFormatDate(ventaState.venta!.fecha),
            isGridview: false,
            backRoute: '/ventas',
            onTap: () => {context.go('/det_venta')},
          );
  }

  Container container(BuildContext context, Widget widget) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Theme.of(context).primaryColor.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: widget,
    );
  }
}
