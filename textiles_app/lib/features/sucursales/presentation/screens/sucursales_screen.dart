import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:textiles_app/features/shared/shared.dart';
import 'package:textiles_app/features/sucursales/domain/entities/sucursal.dart';
import 'package:textiles_app/features/sucursales/presentation/providers/providers.dart';

class SucursalesScreen extends ConsumerWidget {
  const SucursalesScreen({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final sucursalesState = ref.watch(sucursalesProvider);
    return Screen1(widget: _buildBody(sucursalesState.sucursales,context,ref), title: 'Sucursales');
  }

  List<Widget> _buildBody(List<Sucursal> sucursales, BuildContext context,WidgetRef ref) {
    return ([
      ...sucursales.map((sucursal) {
        return ItemDashboard(
          title: sucursal.nombre,
          iconData: Icons.store,
          onTap: _onTap(context, ref, sucursal)
        );
      }).toList()
    ]);
  }

  Function _onTap(BuildContext context,WidgetRef ref, Sucursal sucursal) {
    return () {
      context.go('/ventas/${sucursal.id}');
    };
  }
}
