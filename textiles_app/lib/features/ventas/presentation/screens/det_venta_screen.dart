import 'package:flutter/material.dart';
import 'package:textiles_app/features/shared/shared.dart';
import 'package:textiles_app/features/shared/widgets/data_table_telas.dart';
import 'package:textiles_app/features/telas/domain/domain.dart';
import 'package:textiles_app/features/telas/presentation/providers/providers.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import '../providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetVenta extends ConsumerWidget {
  DetVenta({super.key, required this.idventa});
  final TextEditingController precioController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  final int idventa;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ventaState = ref.watch(ventaProvider(idventa));
    return Screen1(
      widget: _widget(context, ref, ventaState.venta!),
      title: 'Registro Ventas',
      isGridview: false,
      backRoute: true,
    );
  }

  List<Widget> _widget(BuildContext context, WidgetRef ref, Venta venta) {
    final telasState = ref.watch(telasProvider);
    final detalleVentaForm = ref.watch(detalleVentaFormProvider(venta));
    final detVentaFormNotifier =
        ref.read(detalleVentaFormProvider(venta).notifier);
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
                            detVentaFormNotifier
                                .onPrecxCompraChanged(value?.precxcompra ?? 0);
                            detVentaFormNotifier.onNombreChanged(value!.nombre);
                            detVentaFormNotifier.onIdTelasChanged(value.id);
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
                    children: [
                      MiTextField(
                        flex: 3,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        label: 'Precio',
                        onChanged: detVentaFormNotifier.onPrecioChanged,
                        controller: precioController,
                      ),
                      MiTextField(
                        flex: 3,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        label: 'Cantidad',
                        onChanged: detVentaFormNotifier.onCantidadChanged,
                        controller: cantidadController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  MaterialButtonWidget(
                      ontap: () {
                        detVentaFormNotifier.addDetalleVenta();
                        cantidadController.clear();
                        precioController.clear();
                      },
                      texto: 'Añadir'),
                ],
              ),
            ),
      const Divider(
        thickness: 1,
      ),
      DataTableMapTelas(
          listheader: const ['Nombre', 'Cantidad','Precio', 'Total',''],
          listbody: detalleVentaForm.detVentas,
          total: detalleVentaForm.total,
          onTap: (int idtelas, double cantidad, double precio) {
            detVentaFormNotifier.removeDetalleVenta(idtelas, cantidad, precio);
          }),
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: TextFormField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: detVentaFormNotifier.onDescuentoChanged,
          decoration: const InputDecoration(
            labelText: 'Descuento',
            suffixText: 'Bs',
            suffixStyle: TextStyle(fontSize: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
      Container(
          padding: const EdgeInsets.all(12.0),
          child: MaterialButtonWidget(
            ontap: () async {
              final bool value = await detVentaFormNotifier.onFormSubmit();
              if (context.mounted) showSnackbarBool(context, value);
            },
            texto: 'Guardar',
          ))
    ];
  }
}
