import 'package:flutter/material.dart';
import 'package:textiles_app/features/shared/shared.dart';
import '../providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetVenta extends ConsumerWidget {
  const DetVenta({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telas = [
      {'nombre': 'Tela 1', 'cantidad': 10, 'precio': 100, 'total': 1000},
      {'nombre': 'Tela 2', 'cantidad': 20, 'precio': 200, 'total': 4000},
      {'nombre': 'Tela 3', 'cantidad': 30, 'precio': 300, 'total': 9000}
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: DropdownButton<Map<String, dynamic>>(
                      value: telas[0],
                      items: telas.map<DropdownMenuItem<Map<String, dynamic>>>(
                          (Map<String, dynamic> value) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: value,
                          child: Text(value['nombre']),
                        );
                      }).toList(),
                      onChanged: (Map<String, dynamic>? value) {
                        ref
                            .read(detalleVentaFormProvider.notifier)
                            .onIdTelasChanged(value!['idtelas']);
                        ref
                            .read(detalleVentaFormProvider.notifier)
                            .onNombreChanged(value['nombre']);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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



        /* child: CustomTextFormField(
          label: texto,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged:
              onChanged, 
          errorMessage: errorMessage,
        ), */