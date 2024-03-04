import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/shared/shared.dart';
import 'package:textiles_app/features/sucursales/domain/domain.dart';
import 'package:textiles_app/features/sucursales/presentation/providers/providers.dart';

class SucursalScreen extends ConsumerWidget {
  final bool b;
  const SucursalScreen({super.key, required this.b});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (b) {
      ref.read(sucursalProvider.notifier).nuevaSucursal();
    }
    final sucursalState = ref.watch(sucursalProvider);
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: sucursalState.isLoading
            ? const FullScreenLoader()
            : Screen1(
                widget: _sucursalView(sucursalState.sucursal!, context, ref),
                title: b ? 'Crear Sucursal' : 'Editar Sucursal',
                isGridview: false));
  }

  List<Widget> _sucursalView(
      Sucursal sucursal, BuildContext context, WidgetRef ref) {
    final sucursalForm = ref.watch(sucursalFormProvider(sucursal));
    final textStyles = Theme.of(context).textTheme;
    return ([
      Center(
          child: Text(
        sucursalForm.nombre.value,
        style: textStyles.titleSmall,
        textAlign: TextAlign.center,
      )),
      const SizedBox(height: 10),
      _sucursalInformation(sucursal, context, ref),
    ]);
  }

  Widget _sucursalInformation(
      Sucursal sucursal, BuildContext context, WidgetRef ref) {
    final sucursalForm = ref.watch(sucursalFormProvider(sucursal));

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomProductField(
              label: 'Nombre',
              initialValue: sucursalForm.nombre.value,
              onChanged: ref
                  .read(sucursalFormProvider(sucursal).notifier)
                  .onNombreChanged,
              errorMessage: sucursalForm.nombre.errorMessage,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {                
                ref.read(sucursalFormProvider(sucursal).notifier).onFormSubmit();
              },
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Guardar',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
