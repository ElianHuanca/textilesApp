import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:textiles_app/features/shared/shared.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import 'package:textiles_app/features/ventas/presentation/providers/providers.dart';

class VentasScreen extends ConsumerWidget {
  final int idsucursales;
  const VentasScreen({super.key, required this.idsucursales});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ventasState = ref.watch(ventasProvider(idsucursales));    
    return Screen1(widget: _buildBody(ventasState.ventas,context,ref), title: 'Ventas');
    
  }

  List<Widget> _buildBody(List<Venta> ventas, BuildContext context,WidgetRef ref) {
    return ([
      ...ventas.map((venta) {
        return ItemDashboard(
          title: venta.fecha,
          iconData: Icons.calendar_month_rounded,
          onTap: _onTap(context, ref, venta),
        );
      }).toList()
    ]);
  }

  Function _onTap(BuildContext context,WidgetRef ref, Venta venta) {
    return () {
      ref.read(ventaProvider.notifier).setVenta(venta);
      context.go('/det_ventas');
    };
  }
}
