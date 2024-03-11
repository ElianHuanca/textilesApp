import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:textiles_app/features/shared/shared.dart';
import 'package:textiles_app/features/telas/domain/domain.dart';
import 'package:textiles_app/features/telas/presentation/providers/providers.dart';
import '../providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetVenta extends ConsumerWidget {
  const DetVenta({super.key});
  
  //final TextEditingController cantidadController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Screen1(
      widget: _widget(context, ref),
      title: 'Registro Ventas',
      isGridview: false,
      backRoute: '/det_ventas',
    );
  }

  List<Widget> _widget(BuildContext context, WidgetRef ref) {
    final TextEditingController precioController = TextEditingController();
    final telasState = ref.watch(telasProvider);
    final detalleVentaForm = ref.watch(detalleVentaFormProvider);
    return [
      telasState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: DropdownMenu<Tela>(
                          width: MediaQuery.of(context).size.width * 0.93,
                          hintText: 'Seleccione una Tela',
                          onSelected: (value) {
                            ref
                                .read(detalleVentaFormProvider.notifier)
                                .onNombreChanged(value!.nombre);
                            ref
                                .read(detalleVentaFormProvider.notifier)
                                .onIdTelasChanged(value.id);
                          },
                          dropdownMenuEntries: telasState.telas
                              .map<DropdownMenuEntry<Tela>>((e) {
                            return DropdownMenuEntry<Tela>(
                              value: e,
                              label: e.nombre,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MiTextField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        //flex: 3,
                        label: 'Precio',
                        initialValue: '',
                        onChanged: (String p1) => {
                          ref
                              .read(detalleVentaFormProvider.notifier)
                              .onPrecioChanged(p1),
                        },
                        controller: precioController,
                      ),
                      /* MiTextField(
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        flex: 3,
                        label: 'Cantidad',
                        value: detalleVentaForm.cantidad,
                        onChanged: (String p1) {
                          ref
                              .read(detalleVentaFormProvider.notifier)
                              .onCantidadChanged(p1);
                        },
                        controller: cantidadController,
                      ), */
                    ],
                  ),
                  const SizedBox(height: 15),
                  MaterialButtonWidget(ontap: _onAdd(ref), texto: 'Añadir'),
                ],
              ),
            ),
      const Divider(
        thickness: 1,
      ),
      DataTableMap(
          list: detalleVentaForm.detVentas, total: detalleVentaForm.total),
      Container(
          padding: const EdgeInsets.all(12.0),
          child: MaterialButtonWidget(
              ontap: () => {
                    ref.read(detalleVentaFormProvider.notifier).onFormSubmit(),
                    context.go('/det_ventas')
                  },
              texto: 'Guardar'))
    ];
  }

  Function _onAdd(WidgetRef ref) {
    return () {
      ref.read(detalleVentaFormProvider.notifier).addDetalleVenta();
      /* cantidadController.clear();
      precioController.clear(); */
    };
  }
}

/*
isela@gmail.com
Huanca1962
*/