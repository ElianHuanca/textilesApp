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
    final ventaState = ref.watch(ventaProvider(idventa));
    final detalleVentasState = ref.watch(detalleVentasProvider(idventa));    
    return detalleVentasState.isLoading && ventaState.isLoading
        ? const FullScreenLoader()
        : Screen1(
            widget: [
              container(
                  context,
                  detalleVentasState.detalleVentas.isEmpty
                      ? const Center(
                          child: Text('Lista Vacia',
                              style: TextStyle(fontStyle: FontStyle.italic)),
                        )
                      : dataTableWidget(
                          ['Producto', 'Cantidad', 'Precio', 'Total'],
                          context,
                          detalleVentasState.detalleVentas,
                          ventaState.venta!.total,
                          ventaState.venta!.ganancias,
                          ventaState.venta!.descuento,
                        ))
            ],
            title: changeFormatDate(ventaState.venta!.fecha),
            isGridview: false,
            backRoute: true,
            onTap: () => {context.push('/det_venta')},
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
