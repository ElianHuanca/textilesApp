// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/shared/shared.dart';
import 'package:teslo_shop/features/telas/presentation/providers/telas_provider.dart';

class VentaFormScreen extends ConsumerWidget {
  const VentaFormScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //List<DetalleVenta> detventas = [];
    final telasState = ref.watch(telasProvider);
    return Scaffold(
      body: telasState.isLoading
          ? const FullScreenLoader()
          : ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 30),
                        title: Text('Registro De Ventas',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.white)),
                        /* subtitle: Text(
                      'Total: ${ventas.total} Bs Ganancia: ${ventas.ganancias} Bs',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.white70)), */
                        trailing: SizedBox(
                          width: 56,
                          height: 56,
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            elevation: 4,
                            onPressed: () {},
                            child: const Icon(Icons.save_rounded),
                          ),
                        ),
                      )
                      //const SizedBox(height: 30)
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(100))),
                    child: ListView(
                      padding: const EdgeInsets.all(8.0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [_VentaInformation()],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _VentaInformation extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController tela = TextEditingController();
  final TextEditingController cantidad = TextEditingController();
  final TextEditingController precio = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //AQUI EMPIEZA EL FOR
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: TextFormField(
                        controller: tela,
                        decoration: const InputDecoration(
                          labelText: 'Tela',
                          hintText: 'Ingrese la tela',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor ingrese la tela';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: TextFormField(
                        controller: cantidad,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: const Text('Cantidad'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == '0') {
                            return 'Por favor ingrese la cantidad';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: TextFormField(
                        controller: precio,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Precio',
                          hintText: 'Ingrese el precio',
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == '0') {
                            return 'Por favor ingrese el precio';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
