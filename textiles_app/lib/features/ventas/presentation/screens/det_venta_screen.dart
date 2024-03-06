import 'package:flutter/material.dart';
import 'package:textiles_app/features/shared/shared.dart';
import 'package:textiles_app/features/telas/domain/domain.dart';
import 'package:textiles_app/features/telas/presentation/providers/providers.dart';
import '../providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetVenta extends ConsumerWidget {
  const DetVenta({super.key});

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
                  3,
                  'Precio',
                  (String p1) => ref
                      .read(detalleVentaFormProvider.notifier)
                      .onPrecioChanged(double.parse(p1)),
                  detalleVentaForm.precio.errorMessage,
                ),
                _expanded(3, 'Cantidad', (String p1) {
                  ref
                      .read(detalleVentaFormProvider.notifier)
                      .onCantidadChanged(double.parse(p1));
                }, detalleVentaForm.cantidad.errorMessage),
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
    };
  }

  Expanded _expanded(int flex, String texto, Function(String)? onChanged,
      String? errorMessage) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: onChanged,
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




/* DropdownButton<Map<String, dynamic>>(
            value: widget.telas[0],
            items: widget.telas.map<DropdownMenuItem<Map<String, dynamic>>>(
              (Map<String, dynamic> value) {
                return DropdownButtonItem<Map<String, dynamic>>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(value['nombre']),
                  ),
                );
              },
            ).toList(),
            onChanged: (Map<String, dynamic>? value) {
              setState(() {
                widget.telas[0] = value!;
              });
            },
          ) */

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