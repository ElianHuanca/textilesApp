import 'package:flutter/material.dart';
import 'package:textiles_app/features/shared/shared.dart';
import 'package:textiles_app/features/telas/domain/domain.dart';
import 'package:textiles_app/features/telas/presentation/providers/providers.dart';
import '../providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetVenta extends ConsumerWidget {
  DetVenta({super.key});
  final TextEditingController precioController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Screen1(
      widget: _widget(context, ref),
      title: 'Registro de Ventas',
      isGridview: false,
    );
  }

  List<Widget> _widget(BuildContext context, WidgetRef ref) {
    final telasState = ref.watch(telasProvider);
    final detalleVentaForm = ref.watch(detalleVentaFormProvider);

    return [
      Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownMenu<Tela>(
                      width: double.maxFinite,
                      hintText: 'Seleccione una Tela',
                      onSelected: (value) {
                        ref
                            .read(detalleVentaFormProvider.notifier)
                            .onNombreChanged(value!.nombre);
                        ref
                            .read(detalleVentaFormProvider.notifier)
                            .onIdTelasChanged(value.id);
                      },
                      dropdownMenuEntries:
                          telasState.telas.map<DropdownMenuEntry<Tela>>((e) {
                        return DropdownMenuEntry<Tela>(
                          value: e,
                          label: e.nombre,
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _expanded(
                    ref,
                    3,
                    'Precio',
                    detalleVentaForm.precio,
                    precioController,
                    (String p1) => {
                          ref
                              .read(detalleVentaFormProvider.notifier)
                              .onPrecioChanged(p1),
                          //_precioController.text = p1
                        },
                    ''
                    //detalleVentaForm.precio.errorMessage,
                    ),
                _expanded(ref, 3, 'Cantidad', detalleVentaForm.cantidad,
                    cantidadController, (String p1) {
                  ref
                      .read(detalleVentaFormProvider.notifier)
                      .onCantidadChanged(p1);
                }, ''), //detalleVentaForm.cantidad.errorMessage, cantidadController),
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
      dataTableMap(context, detalleVentaForm.detVentas, detalleVentaForm.total)
    ];
  }

  Function _onAdd(WidgetRef ref) {
    return () {
      ref.read(detalleVentaFormProvider.notifier).addDetalleVenta();
      print(ref.watch(detalleVentaFormProvider).detVentas);
      cantidadController.clear();
    };
  }

  Expanded _expanded(
      WidgetRef ref,
      int flex,
      String texto,
      String value,
      TextEditingController controller,
      Function(String)? onChanged,
      String? errorMessage) {
    controller.text = value;
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: onChanged,
            onTap: () {
              ref.read(detalleVentaFormProvider.notifier).onPrecioChanged('');
              controller.clear();
            },
            decoration: InputDecoration(
              label: Text(texto),
              errorText: errorMessage,
              suffixText: texto == 'Precio' ? 'Bs' : 'mts',
              suffixStyle: const TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )),
      ),
    );
  }
}

/* TextFormField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: onChanged,
            decoration: InputDecoration(
              label: Text(texto),
              errorText: errorMessage,
              suffixText: texto == 'Precio'
                  ? 'Bs'
                  : (texto == 'Cantidad' ? 'mts' : null),
              suffixStyle: const TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )), */

class MiTextField extends StatelessWidget {
  final String texto;
  final String value;
  final Function(String)? onChanged;
  final String? errorMessage;
  final TextEditingController controller;

  const MiTextField(
      {Key? key,
      required this.texto,
      required this.value,
      required this.onChanged,
      required this.errorMessage,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = value;
    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: onChanged,
            onTap: () {
              // ref.read(detalleVentaFormProvider.notifier).onPrecioChanged(0);
              // controller.clear();
            },
            decoration: InputDecoration(
              label: Text(texto),
              errorText: errorMessage,
              suffixText: texto == 'Precio' ? 'Bs' : 'mts',
              suffixStyle: const TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )),
      ),
    );
  }
}
