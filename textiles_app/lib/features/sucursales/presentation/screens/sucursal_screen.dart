import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final sucursalFormNotifier =
        ref.read(sucursalFormProvider(sucursal).notifier);
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                MiTextField(
                  label: 'Nombre',
                  initialValue: sucursalForm.nombre,
                  onChanged: sucursalFormNotifier.onNombreChanged,
                ),
              ],
            ),
            const SizedBox(height: 20),
            MaterialButtonWidget(
              ontap: () async {
                final bool value = await sucursalFormNotifier.onSubmit(
                    isUpdate: sucursal.id != 0);
                if (context.mounted) showSnackbarBool(context, value);
              },
              texto: sucursal.id == 0 ? 'Guardar' : 'Modificar',
            ),
            const SizedBox(height: 15),
            if (sucursal.id != 0)
              MaterialButtonWidget(
                ontap: () async {
                  final bool value = await sucursalFormNotifier.onDelete();
                  if (context.mounted) showSnackbarBool(context, value);
                },
                texto: 'Eliminar',
              )
          ],
        ));
  }
}
