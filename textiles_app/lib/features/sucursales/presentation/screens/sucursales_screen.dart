import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:textiles_app/features/shared/shared.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class SucursalesScreen extends ConsumerWidget {
  final bool gSucursales;
  const SucursalesScreen(this.gSucursales, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sucursalesState = ref.watch(sucursalesProvider);
    return Screen1(
      widget: _buildBody(sucursalesState.sucursales, context, ref, gSucursales),
      title: 'Sucursales',
      isGridview: true,
    );
  }

  List<Widget> _buildBody(List<Sucursal> sucursales, BuildContext context,
      WidgetRef ref, bool gSucursales) {
    return ([
      ...sucursales.map((sucursal) {
        return ItemDashboard(
            title: sucursal.nombre,
            iconData: Icons.store,
            onTap: _onTap(context, ref, sucursal, gSucursales));
      }).toList(),
      gSucursales
          ? ItemDashboard(
              title: 'Agregar Sucusal',
              iconData: Icons.add_business_rounded,
              onTap: _onTap2(context, ref))
          : const SizedBox(),
    ]);
  }

  //ACTUALIZAR|ELIMINAR SUCURSAL O VER VENTAS
  Function _onTap(BuildContext context, WidgetRef ref, Sucursal sucursal,
      bool gSucursales) {
    return () {
      ref.read(sucursalProvider.notifier).setSucursal(sucursal);
      gSucursales ? context.go('/sucursal') : context.go('/ventas');
    };
  }

  //CREAR SUCURSAL
  Function _onTap2(BuildContext context, WidgetRef ref) {
    return () {
      ref.read(sucursalProvider.notifier).nuevaSucursal();
      context.go('/sucursal');
    };
  }
}
