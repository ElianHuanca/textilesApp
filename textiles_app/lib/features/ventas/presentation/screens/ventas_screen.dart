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
      widget: _buildBody(ventasState.ventas, context),
      title: 'Ventas',
      isGridview: true,
      backRoute: true,
    );
  }

  List<Widget> _buildBody(
      List<Venta> ventas, BuildContext context) {
    return ([
      ...ventas.map((venta) {
        final String fecha = changeFormatDate(venta.fecha);
        return ItemDashboard(
          title: fecha,
          iconData: Icons.calendar_month_rounded,
          onTap: _onTap(context, venta.id),
        );
      }).toList()
    ]);
  }

  Function _onTap(BuildContext context, int idventa) {
    return () {      
      context.push('/det_ventas/$idventa');
    };
  }
}
