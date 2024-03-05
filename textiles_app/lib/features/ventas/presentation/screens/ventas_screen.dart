import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:textiles_app/features/shared/shared.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class VentasScreen extends ConsumerWidget {
  const VentasScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ventasState = ref.watch(ventasProvider);    
    return Screen1(widget: _buildBody(ventasState.ventas,context,ref), title: 'Ventas', isGridview: true,);    
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
