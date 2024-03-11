import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/shared/shared.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';
import 'package:go_router/go_router.dart';

class TelaScreen extends ConsumerWidget {
  const TelaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telaState = ref.watch(telaProvider);
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: telaState.isLoading
            ? const FullScreenLoader()
            : Screen1(
                widget: [_telaInformation(telaState.tela!, context, ref)],
                title: telaState.tela!.id == 0 ? 'Crear Tela' : 'Editar Tela',
                isGridview: false,
                backRoute: '/telas',
              ));
  }

  /* List<Widget> _telaView(Tela tela, BuildContext context, WidgetRef ref) {
    final telaForm = ref.watch(telaFormProvider(tela));
    final textStyles = Theme.of(context).textTheme;
    return ([
      Center(
          child: Text(
        telaForm.nombre.value,
        style: textStyles.titleSmall,
        textAlign: TextAlign.center,
      )),
      const SizedBox(height: 10),
      _telaInformation(tela, context, ref),
    ]);
  } */

  Widget _telaInformation(Tela tela, BuildContext context, WidgetRef ref) {
    final telaForm = ref.watch(telaFormProvider(tela));

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
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
                  onChanged: (value) => ref
                      .read(telaFormProvider(tela).notifier)
                      .onPrecxmenChanged(value),
                ),
                MiTextField(
                  label: 'Precio X Mayor',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  initialValue: telaForm.precxmay,
                  onChanged: (value) => ref
                      .read(telaFormProvider(tela).notifier)
                      .onPrecxmayChanged(value),
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
                  onChanged: (value) => ref
                      .read(telaFormProvider(tela).notifier)
                      .onPrecxrolloChanged(value),
                ),
                MiTextField(
                  label: 'Precio Compra',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  initialValue: telaForm.precxcompra,
                  onChanged: (value) => ref
                      .read(telaFormProvider(tela).notifier)
                      .onPrecxcompraChanged(value),
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
    return () {
      tela.id == 0
          ? {
              ref.read(telaFormProvider(tela).notifier).onCreateSubmit().then(
                  (value) => value
                      ? showSnackbar(context, 'Creado Correctamente')
                      : showSnackbar(context, 'Hubo Un Error'))
            }
          : {
              ref.read(telaFormProvider(tela).notifier).onUpdateSubmit().then(
                  (value) => value
                      ? showSnackbar(context, 'Modificado Correctamente')
                      : showSnackbar(context, 'Hubo Un Error'))
            };
      context.go('/telas');
    };
  }

  Function _onDelete(BuildContext context, WidgetRef ref, Tela tela) {
    return () {
      ref.read(telaFormProvider(tela).notifier).onDeleteSubmit().then((value) =>
          value
              ? showSnackbar(context, 'Eliminado Correctamente')
              : showSnackbar(context, 'Hubo Un Error'));
      context.go('/telas');
    };
  }
}
