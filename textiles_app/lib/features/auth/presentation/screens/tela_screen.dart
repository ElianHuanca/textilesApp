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
    ref.read(loginFormProvider.notifier).userCallback;
    final usuarioState = ref.watch(loginFormProvider);
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Screen1(
          widget: [_usuarioInformation(usuarioState, context, ref)],
          title: 'Editar Perfil',
          isGridview: false,
          backRoute: '/usuarios',
        ));
  }

  Widget _usuarioInformation(
      Usuario usuario, BuildContext context, WidgetRef ref) {
    final usuarioForm = ref.watch(usuarioFormProvider(usuario));

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
                  initialValue: usuarioForm.nombre,
                  onChanged: ref
                      .read(usuarioFormProvider(usuario).notifier)
                      .onNombreChanged,
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
                  initialValue: usuarioForm.precxmen,
                  onChanged: (value) => ref
                      .read(usuarioFormProvider(usuario).notifier)
                      .onPrecxmenChanged(value),
                ),
                MiTextField(
                  label: 'Precio X Mayor',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  initialValue: usuarioForm.precxmay,
                  onChanged: (value) => ref
                      .read(usuarioFormProvider(usuario).notifier)
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
                  initialValue: usuarioForm.precxrollo,
                  onChanged: (value) => ref
                      .read(usuarioFormProvider(usuario).notifier)
                      .onPrecxrolloChanged(value),
                ),
                MiTextField(
                  label: 'Precio Compra',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  initialValue: usuarioForm.precxcompra,
                  onChanged: (value) => ref
                      .read(usuarioFormProvider(usuario).notifier)
                      .onPrecxcompraChanged(value),
                ),
              ],
            ),
            const SizedBox(height: 15),
            MaterialButtonWidget(
              ontap: _onSubmit(context, ref, usuario),
              texto: usuario.id == 0 ? 'Guardar' : 'Modificar',
            ),
            const SizedBox(height: 15),
            usuario.id != 0
                ? MaterialButtonWidget(
                    ontap: _onDelete(context, ref, usuario), texto: 'Eliminar')
                : const SizedBox(),
          ],
        ));
  }

  Function _onSubmit(BuildContext context, WidgetRef ref, Tela usuario) {
    return () {
      usuario.id == 0
          ? {
              ref
                  .read(usuarioFormProvider(usuario).notifier)
                  .onCreateSubmit()
                  .then((value) => value
                      ? showSnackbar(context, 'Creado Correctamente')
                      : showSnackbar(context, 'Hubo Un Error'))
            }
          : {
              ref
                  .read(usuarioFormProvider(usuario).notifier)
                  .onUpdateSubmit()
                  .then((value) => value
                      ? showSnackbar(context, 'Modificado Correctamente')
                      : showSnackbar(context, 'Hubo Un Error'))
            };
      context.go('/usuarios');
    };
  }

  Function _onDelete(BuildContext context, WidgetRef ref, Tela usuario) {
    return () {
      ref.read(usuarioFormProvider(usuario).notifier).onDeleteSubmit().then(
          (value) => value
              ? showSnackbar(context, 'Eliminado Correctamente')
              : showSnackbar(context, 'Hubo Un Error'));
      context.go('/usuarios');
    };
  }
}
