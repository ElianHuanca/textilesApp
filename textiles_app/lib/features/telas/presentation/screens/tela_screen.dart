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
                  onChanged:
                      ref.read(telaFormProvider(tela).notifier).onNombreChanged,
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
                  onChanged: ref
                      .read(telaFormProvider(tela).notifier)
                      .onPrecxmenChanged,
                ),
                MiTextField(
                  label: 'Precio X Mayor',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  initialValue: telaForm.precxmay,
                  onChanged: ref
                      .read(telaFormProvider(tela).notifier)
                      .onPrecxmayChanged,
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
                  onChanged: ref
                      .read(telaFormProvider(tela).notifier)
                      .onPrecxrolloChanged,
                ),
                MiTextField(
                  label: 'Precio Compra',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  initialValue: telaForm.precxcompra,
                  onChanged: ref
                      .read(telaFormProvider(tela).notifier)
                      .onPrecxcompraChanged,
                ),
              ],
            ),
            const SizedBox(height: 15),
            MaterialButtonWidget(
              ontap: _onSubmit(context, ref, tela),
              texto: tela.id == 0 ? 'Guardar' : 'Modificar',
            ),
            const SizedBox(height: 15),
            tela.id != 0
                ? MaterialButtonWidget(
                    ontap: _onDelete(context, ref, tela), texto: 'Eliminar')
                : const SizedBox(),
          ],
        ));
  }

  Function _onSubmit(BuildContext context, WidgetRef ref, Tela tela) {
    return () async {
      final bool value = await ref
          .read(telaFormProvider(tela).notifier)
          .onSubmit(isUpdate: tela.id != 0);
      if (context.mounted) {
        showSnackbarBool(context, value);
      }
    };
  }

  Function _onDelete(BuildContext context, WidgetRef ref, Tela tela) {
    return () async {
      final bool value =
          await ref.read(telaFormProvider(tela).notifier).onDeleteSubmit();
      if (context.mounted) {
        showSnackbarBool(context, value);
      }
    };
  }
}
