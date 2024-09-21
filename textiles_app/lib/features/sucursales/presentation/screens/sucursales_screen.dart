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
    return sucursalesState.isLoading
        ? const FullScreenLoader()
        : Screen1(
            backRoute: false,
            widget: _buildBody(
                sucursalesState.sucursales, context, ref, gSucursales),
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
            onTap: _onTap(context, sucursal.id, gSucursales));
      }).toList(),
      gSucursales
          ? ItemDashboard(
              title: 'Agregar Sucusal',
              iconData: Icons.add_business_rounded,
              onTap: _onTap2(context))
          : const SizedBox(),
    ]);
  }  
  Function _onTap(BuildContext context, int idsucursal, bool gSucursales) {
    return () {      
      gSucursales
          ? context.push('/sucursal/$idsucursal')
          : context.push('/ventas/$idsucursal');
    };
  }

  //CREAR SUCURSAL
  Function _onTap2(BuildContext context) {
    return () {      
      context.push('/sucursal/0');
    };
  }
}
