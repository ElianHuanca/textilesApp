import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/shared/shared.dart';
import 'package:teslo_shop/features/telas/domain/entities/tela.dart';
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
                        trailing: SizedBox(
                          width: 56,
                          height: 56,
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            elevation: 4,
                            onPressed: () {
                              print(telasState.telas);
                            },
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
                      child: DropdownMenuExample(telasState.telas)),
                ),
              ],
            ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  final List<Tela> telas;
  const DropdownMenuExample(this.telas);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String nombre = '';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cantidad = TextEditingController();
  final TextEditingController precio = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nombre = widget.telas[0].nombre;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: DropdownMenu<Tela>(
                                initialSelection: widget.telas[0],
                                onSelected: (Tela? value) {
                                  setState(() {
                                    nombre = value!.nombre;
                                    precio.text = value.precxmen.toString();
                                  });
                                },
                                dropdownMenuEntries: widget.telas
                                    .map<DropdownMenuEntry<Tela>>(
                                        (Tela tela) {
                                  return DropdownMenuEntry<Tela>(
                                      value: tela, label: tela.nombre);
                                }).toList(),
                                //isExpanded: true,
                              ),
                            ),
                          ),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
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
                            padding: const EdgeInsets.all(2.0),
                            child: TextFormField(
                              controller: precio,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                label: const Text('Precio'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]);
  }
}

/* class MyDropdownWidget extends StatefulWidget {
  final List<Tela> telas;

  MyDropdownWidget(this.telas);

  @override
  _MyDropdownWidgetState createState() => _MyDropdownWidgetState();
}

class _MyDropdownWidgetState extends State<MyDropdownWidget> {
  Tela? _selectedTela;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(8.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 30),
          Form(
              key: _formKey,
              child: Column(children: [
                //AQUI EMPIEZA EL FOR
                Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () {
                                RenderBox renderBox =
                                    context.findRenderObject() as RenderBox;
                                Rect rect =
                                    renderBox.localToGlobal(Offset.zero) &
                                        renderBox.size;
                                final Offset position =
                                    Offset(rect.left, rect.bottom);
                                final Size size = rect.size;
                                final RelativeRect positionPopup =
                                    RelativeRect.fromLTRB(0, size.height, 0, 0);

                                showMenu(
                                  context: context,
                                  position: positionPopup,
                                  items: widget.telas.map((tela) {
                                    return PopupMenuItem<Tela>(
                                      value: tela,
                                      child: Text(tela.nombre),
                                    );
                                  }).toList(),
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedTela = value;
                                    });
                                  }
                                });
                              },
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Tela',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(_selectedTela != null
                                        ? _selectedTela!.nombre
                                        : 'Seleccionar Tela'),
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ])
                ])
              ]))
        ]);
  }
} */
/**/
/* class _VentaInformation extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController tela = TextEditingController();
  final TextEditingController cantidad = TextEditingController();
  final TextEditingController precio = TextEditingController();
  final List<Tela> telas;
  _VentaInformation(this.telas);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Tela selectedTela = telas[0];
    return ListView(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 30),
        Form(
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
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Consumer(builder: (context, ref, child) {
                            final selectedTela = ref.watch(
                                ); // Obtener el valor actual de selectedTela
                            return DropdownButtonFormField<Tela>(
                              value: selectedTela, // Valor seleccionado
                              onChanged: (newValue) {
                                ref.read(selectedTelaProvider.notifier).update(
                                    newValue); // Actualizar el valor de selectedTela
                              },
                              items: telas.map((tela) {
                                return DropdownMenuItem<Tela>(
                                  value: tela,
                                  child: Text(tela
                                      .nombre), // Suponiendo que Tela tiene un campo 'nombre'
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: 'Tela',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Por favor seleccione una tela';
                                }
                                return null;
                              },
                            );
                          }),
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
                          padding: const EdgeInsets.all(2.0),
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
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            controller: precio,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: const Text('Precio'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
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
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(
            //borderRadius: BorderRadius.circular(Adaptive.px(10)),
            borderRadius: BorderRadius.circular(10),
          ),
          color: Theme.of(context).primaryColor,
          onPressed: () => {print(telas)},
          child: const Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SizedBox(width: Adaptive.px(10)),
                SizedBox(width: 10),
                Text(
                  'Añadir',
                  style: TextStyle(color: Colors.white, fontSize: 20 //.sp,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} */
