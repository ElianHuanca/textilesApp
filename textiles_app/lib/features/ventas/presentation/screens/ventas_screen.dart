import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:textiles_app/features/shared/shared.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class VentasScreen extends ConsumerWidget {
  final int idsucursal;
  const VentasScreen({super.key,required this.idsucursal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ventasState = ref.watch(ventasProvider(idsucursal));
    return Screen1(
      widget: _buildBody(ventasState.ventas, context, ref),
      title: 'Ventas',
      isGridview: true,
      backRoute: '/',
    );
  }

  List<Widget> _buildBody(
      List<Venta> ventas, BuildContext context, WidgetRef ref) {
    return ([
      ...ventas.map((venta) {
        final String fecha = changeFormatDate(venta.fecha);
        return ItemDashboard(
          title: fecha,
          iconData: Icons.calendar_month_rounded,
          onTap: _onTap(context, ref, venta),
        );
      }).toList()
    ]);
  }

  Function _onTap(BuildContext context, WidgetRef ref, Venta venta) {
    return () {
      ref.read(ventaProvider.notifier).setVenta(venta);
      context.go('/det_ventas');
    };
  }
}
