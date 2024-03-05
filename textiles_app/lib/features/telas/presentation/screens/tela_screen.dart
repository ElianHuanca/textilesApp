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
                widget: _telaView(telaState.tela!, context, ref),
                title: telaState.tela!.id == 0 ? 'Crear Tela' : 'Editar Tela',
                isGridview: false,
              ));
  }

  List<Widget> _telaView(Tela tela, BuildContext context, WidgetRef ref) {
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
  }

  Widget _telaInformation(Tela tela, BuildContext context, WidgetRef ref) {
    final telaForm = ref.watch(telaFormProvider(tela));

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomProductField(
              isTopField: true,
              label: 'Nombre',
              initialValue: telaForm.nombre.value,
              onChanged:
                  ref.read(telaFormProvider(tela).notifier).onNombreChanged,
              errorMessage: telaForm.nombre.errorMessage,
            ),

            CustomProductField(
              label: 'Precio X Menor',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              initialValue: telaForm.precxmen.value.toString(),
              onChanged: (value) => ref.read(telaFormProvider(tela).notifier).onPrecxmenChanged(double.tryParse(value) ?? -1),
              errorMessage: telaForm.precxmen.errorMessage,
            ),
            
            CustomProductField(
              label: 'Precio X Mayor',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              initialValue: telaForm.precxmay.value.toString(),
              onChanged: (value) => ref.read(telaFormProvider(tela).notifier).onPrecxmayChanged(double.tryParse(value) ?? -1),
              errorMessage: telaForm.precxmay.errorMessage,
            ),

            CustomProductField(
              label: 'Precio X Rollo',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              initialValue: telaForm.precxrollo.value.toString(),
              onChanged: (value) => ref.read(telaFormProvider(tela).notifier).onPrecxrolloChanged(double.tryParse(value) ?? -1),
              errorMessage: telaForm.precxrollo.errorMessage,
            ),

            CustomProductField(
              label: 'Precio Compra',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              initialValue: telaForm.precxcompra.value.toString(),
              onChanged: (value) => ref.read(telaFormProvider(tela).notifier).onPrecxcompraChanged(double.tryParse(value) ?? -1),
              errorMessage: telaForm.precxcompra.errorMessage,
            ),

            const SizedBox(height: 15),
            MaterialButtonWidget(
              ontap: _onSubmit(context, ref, tela),
              texto: tela.id == 0 ? 'Guardar' : 'Modificar',
            ),
            tela.id == 0
                ? MaterialButtonWidget(
                    ontap: _onDelete(context, ref, tela), texto: 'Eliminar')
                : const SizedBox(),
          ],
        ));
  }

  Function _onSubmit(BuildContext context, WidgetRef ref, Tela tela) {
    return () {      
      ref.read(telaFormProvider(tela).notifier).onFormSubmit().then((value) => value ?  showSnackbar(context, tela.id==0 ? 'Guardado' : 'Editado') : showSnackbar(context, 'Hubo Un Error'));
      context.go('/telas');
    };
  }

  Function _onDelete(BuildContext context, WidgetRef ref, Tela tela) {
    return () {
      ref.read(telaFormProvider(tela).notifier).onFormDelete().then((value) => value ?  showSnackbar(context, 'Eliminado') : showSnackbar(context, 'Hubo Un Error'));
      context.go('/telas');
    };
  }
}
