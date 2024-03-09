import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:textiles_app/features/shared/shared.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class SucursalScreen extends ConsumerWidget {
  const SucursalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sucursalState = ref.watch(sucursalProvider);
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: sucursalState.isLoading
            ? const FullScreenLoader()
            : Screen1(
                widget: [
                    const SizedBox(
                      height: 10,
                    ),
                    _sucursalInformation(sucursalState.sucursal!, context, ref)
                  ],
                title: sucursalState.sucursal!.id == 0
                    ? 'Crear Sucursal'
                    : 'Editar Sucursal',
                isGridview: false));
  }

  Widget _sucursalInformation(
      Sucursal sucursal, BuildContext context, WidgetRef ref) {
    final sucursalForm = ref.watch(sucursalFormProvider(sucursal));

    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MiTextField(                  
                  label: 'Nombre',
                  value: sucursalForm.nombre,
                  onChanged: (value) => ref
                      .read(sucursalFormProvider(sucursal).notifier)
                      .onNombreChanged(value),
                ),
              ],
            ),
            const SizedBox(height: 50),
            MaterialButtonWidget(
              ontap: _onSubmit(context, ref, sucursal),
              texto: sucursal.id == 0 ? 'Guardar' : 'Modificar',
            ),
            const SizedBox(height: 15),
            sucursal.id != 0
                ? MaterialButtonWidget(
                    ontap: _onDelete(context, ref, sucursal), texto: 'Eliminar')
                : const SizedBox(),
          ],
        ));
  }

  Function _onSubmit(BuildContext context, WidgetRef ref, Sucursal sucursal) {
    return () {
      ref.read(sucursalFormProvider(sucursal).notifier).onFormSubmit().then(
          (value) => value
              ? showSnackbar(context, sucursal.id == 0 ? 'Guardado' : 'Editado')
              : showSnackbar(context, 'Hubo Un Error'));
      context.go('/sucursales');
    };
  }

  Function _onDelete(BuildContext context, WidgetRef ref, Sucursal sucursal) {
    return () {
      ref.read(sucursalFormProvider(sucursal).notifier).onFormDelete().then(
          (value) => value
              ? showSnackbar(context, 'Eliminado')
              : showSnackbar(context, 'Hubo Un Error'));
      context.go('/sucursales');
    };
  }
}
