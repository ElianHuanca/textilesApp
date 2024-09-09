import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                                .read(detalleVentaFormProvider(venta).notifier)
                                .onPrecxCompraChanged(
                                    value?.precxcompra ?? 0.0);
                            ref
                                .read(detalleVentaFormProvider(venta).notifier)
                                .onNombreChanged(value!.nombre);
                            ref
                                .read(detalleVentaFormProvider(venta).notifier)
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
                    children: [
                      MiTextField(
                        flex: 3,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        label: 'Precio',
                        onChanged: ref
                            .read(detalleVentaFormProvider(venta).notifier)
                            .onPrecioChanged,
                        controller: precioController,
                      ),
                      MiTextField(
                        flex: 3,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        label: 'Cantidad',
                        onChanged: ref
                            .read(detalleVentaFormProvider(venta).notifier)
                            .onCantidadChanged,
                        controller: cantidadController,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  MaterialButtonWidget(
                      ontap: _onAdd(ref, venta), texto: 'Añadir'),
                ],
              ),
            ),
      const Divider(
        thickness: 1,
      ),
      DataTableMapTelas(
          listheader: const ['Nombre', 'Cantidad', 'Total'],
          listbody: detalleVentaForm.detVentas,
          total: detalleVentaForm.total,
          onTap: {
            ref
                .read(detalleVentaFormProvider(venta).notifier)
                .removeDetalleVenta(
                    det['idtelas'], det['cantidad'], det['precio'])
          ),
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: TextFormField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: ref
              .read(detalleVentaFormProvider(venta).notifier)
              .onDescuentoChanged,
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
            ontap: () => {
              //detalleVentaForm.isLoading ? null :
              ref
                  .read(detalleVentaFormProvider(venta).notifier)
                  .onFormSubmit()
                  .then((value) => value
                      ? showSnackbar(context, 'Venta Registrado Correctamente')
                      : showSnackbar(context, 'Hubo Un Error')),
              context.go('/det_ventas')
            },
            texto:
                'Guardar', //detalleVentaForm.isLoading ? 'Guardando...' : 'Guardar'
          ))
    ];
  }

  Function _onAdd(WidgetRef ref, Venta venta) {
    return () {
      ref.read(detalleVentaFormProvider(venta).notifier).addDetalleVenta();
      cantidadController.clear();
      precioController.clear();
    };
  }
}
