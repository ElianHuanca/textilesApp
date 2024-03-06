import 'package:flutter/material.dart';
import 'package:textiles_app/features/shared/shared.dart';
import '../providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetVenta extends ConsumerWidget {
  const DetVenta({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telas = [
      {
        'id': 1,
        'nombre': 'Lino',
      },
      {
        'id': 2,
        'nombre': 'Coshibo',
      },
      {
        'id': 3,
        'nombre': 'Dipiur',
      }
    ];
    return Screen1(
      widget: _widget(context, ref, telas),
      title: 'Registro de Ventas',
      isGridview: false,
    );
  }

  List<Widget> _widget(
      BuildContext context, WidgetRef ref, List<Map<String, dynamic>> telas) {
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
                    child: DropdownMenu<Map<String, dynamic>>(
                      width: double.maxFinite,
                      hintText: 'Seleccione una Tela',
                      onSelected: (value) {
                        ref
                            .read(detalleVentaFormProvider.notifier)
                            .onDropdownValueChanged(value!);
                      },
                      dropdownMenuEntries:telas
                          .map<DropdownMenuEntry<Map<String, dynamic>>>((e) {
                        return DropdownMenuEntry<Map<String, dynamic>>(
                          value: e,
                          label: e['nombre'] as String,
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
                    (p0) => ref
                        .read(detalleVentaFormProvider.notifier)
                        .onPrecioChanged,
                    detalleVentaForm.precio.errorMessage),
                _expanded(
                    3,
                    'Cantidad',
                    (p0) => ref
                        .read(detalleVentaFormProvider.notifier)
                        .onCantidadChanged,
                    detalleVentaForm.cantidad.errorMessage),
              ],
            ),
            const SizedBox(height: 15),
            MaterialButtonWidget(ontap: _onAdd(), texto: 'Añadir'),
          ],
        ),
      ),
      const Divider(
        thickness: 1,
      ),
    ];
  }

  Function _onAdd() {
    return () {};
  }

  Expanded _expanded(int flex, String texto, Function(String) onChanged,
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
              suffixText: texto == 'Precio'
                  ? 'Bs'
                  : (texto == 'Cantidad' ? 'mts' : null),
              suffixStyle: const TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )),
      ),
    );
  }
}

class DropdownMenuWidget extends StatefulWidget {
  final List<Map<String, dynamic>> telas;
  const DropdownMenuWidget({super.key, required this.telas});

  @override
  State<DropdownMenuWidget> createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownMenu<Map<String, dynamic>>(
            width: double.maxFinite,
            hintText: 'Seleccione una Tela',
            onSelected: (value) {
              ref
                  .read(detalleVentaFormProvider.notifier)
                  .onDropdownValueChanged(value!);
            },
            dropdownMenuEntries:
                widget.telas.map<DropdownMenuEntry<Map<String, dynamic>>>((e) {
              return DropdownMenuEntry<Map<String, dynamic>>(
                value: e,
                label: e['nombre'] as String,
              );
            }).toList(),
          ),
        ),
      );
    });
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