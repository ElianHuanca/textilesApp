import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      title: 'Registro Ventas',
      isGridview: false,
      backRoute: '/det_ventas',
    );
  }

  List<Widget> _widget(BuildContext context, WidgetRef ref) {
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
                                .onPrecxCompraChanged(
                                    value?.precxcompra ?? 0.0);
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
                    children: [
                      MiTextField(
                        flex: 3,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        label: 'Precio',
                        onChanged: ref
                            .read(detalleVentaFormProvider.notifier)
                            .onPrecioChanged,
                        controller: precioController,
                      ),
                      MiTextField(
                        flex: 3,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        label: 'Cantidad',
                        onChanged: ref
                            .read(detalleVentaFormProvider.notifier)
                            .onCantidadChanged,
                        controller: cantidadController,
                      ),
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
          list: detalleVentaForm.detVentas,
          total: detalleVentaForm.total,
          detventas: false),
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: TextFormField(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged:
              ref.read(detalleVentaFormProvider.notifier).onDescuentoChanged,
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
              ref.read(detalleVentaFormProvider.notifier).onFormSubmit().then(
                  (value) => value
                      ? showSnackbar(context, 'Venta Registrado Correctamente')
                      : showSnackbar(context, 'Hubo Un Error')),
              context.go('/det_ventas')
            },
            texto:
                'Guardar', //detalleVentaForm.isLoading ? 'Guardando...' : 'Guardar'
          ))
    ];
  }

  Function _onAdd(WidgetRef ref) {
    return () {
      ref.read(detalleVentaFormProvider.notifier).addDetalleVenta();
      cantidadController.clear();
      precioController.clear();
    };
  }
}
