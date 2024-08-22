import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:textiles_app/features/shared/shared.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class SucursalScreen extends ConsumerWidget {
  final int id;
  const SucursalScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sucursalState = ref.watch(sucursalProvider(id));
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: sucursalState.isLoading
            ? const FullScreenLoader()
            : Screen1(
                backRoute: true,
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
                  initialValue: sucursalForm.nombre,
                  onChanged: (value) => ref
                      .read(sucursalFormProvider(sucursal).notifier)
                      .onNombreChanged(value),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
      sucursal.id == 0
          ? {
              ref
                  .read(sucursalFormProvider(sucursal).notifier)
                  .onFormCreate()
                  .then((value) => value
                      ? showSnackbar(context, 'Guardado Correctamente')
                      : showSnackbar(context, 'Hubo Un Error')),
            }
          : {
              ref
                  .read(sucursalFormProvider(sucursal).notifier)
                  .onFormUpdate()
                  .then((value) => value
                      ? showSnackbar(context, 'Modificado Correctamente')
                      : showSnackbar(context, 'Hubo Un Error')),
            };
      context.go('/sucursales');
    };
  }

  Function _onDelete(BuildContext context, WidgetRef ref, Sucursal sucursal) {
    return () {
      ref.read(sucursalFormProvider(sucursal).notifier).onFormDelete().then(
          (value) => value
              ? showSnackbar(context, 'Eliminado Correctamente')
              : showSnackbar(context, 'Hubo Un Error'));
      context.push('/sucursales');
    };
  }
}
