import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/shared/shared.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class TelaScreen extends ConsumerWidget {
  final int id;
  const TelaScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telaState = ref.watch(telaProvider(id));
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: telaState.isLoading
            ? const FullScreenLoader()
            : Screen1(
                widget: [_telaInformation(telaState.tela!, context, ref)],
                title: telaState.tela!.id == 0 ? 'Crear Tela' : 'Editar Tela',
                isGridview: false,
                backRoute: true,
              ));
  }

  Widget _telaInformation(Tela tela, BuildContext context, WidgetRef ref) {
    final telaForm = ref.watch(telaFormProvider(tela));
    final telaFormNotifier = ref.read(telaFormProvider(tela).notifier);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                MiTextField(
                  label: 'Nombre',
                  initialValue: telaForm.nombre,
                  onChanged: telaFormNotifier.onNombreChanged,
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                MiTextField(
                  label: 'Precio X Menor',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  initialValue: telaForm.precxmen,
                  onChanged: telaFormNotifier.onPrecxmenChanged,
                ),
                MiTextField(
                  label: 'Precio X Mayor',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  initialValue: telaForm.precxmay,
                  onChanged: telaFormNotifier.onPrecxmayChanged,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                MiTextField(
                  label: 'Precio X Rollo',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  initialValue: telaForm.precxrollo,
                  onChanged: telaFormNotifier.onPrecxrolloChanged,
                ),
                MiTextField(
                  label: 'Precio Compra',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  initialValue: telaForm.precxcompra,
                  onChanged: telaFormNotifier.onPrecxcompraChanged,
                ),
              ],
            ),
            const SizedBox(height: 15),
            MaterialButtonWidget(
              ontap: () async {
                final bool value =
                    await telaFormNotifier.onSubmit(isUpdate: tela.id != 0);
                if (context.mounted) showSnackbarBool(context, value);
              },
              texto: tela.id == 0 ? 'Guardar' : 'Modificar',
            ),
            const SizedBox(height: 15),
            if (tela.id != 0)
              MaterialButtonWidget(
                ontap: () async {
                  final bool value = await telaFormNotifier.onDeleteSubmit();
                  if (context.mounted) showSnackbarBool(context, value);
                },
                texto: 'Eliminar',
              ),
          ],
        ));
  }
}
