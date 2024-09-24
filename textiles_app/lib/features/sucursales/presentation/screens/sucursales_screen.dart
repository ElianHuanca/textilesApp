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
      ...sucursales
          .map((sucursal) => ItemDashboard(
              title: sucursal.nombre,
              iconData: Icons.store,
              onTap: () => gSucursales
                  ? context.push('/sucursal/${sucursal.id}')
                  : context.push('/ventas/${sucursal.id}')))
          .toList(),
      gSucursales
          ? ItemDashboard(
              title: 'Agregar Sucusal',
              iconData: Icons.add_business_rounded,
              onTap: () => context.push('/sucursal/0'))
          : const SizedBox(),
    ]);
  }
}
