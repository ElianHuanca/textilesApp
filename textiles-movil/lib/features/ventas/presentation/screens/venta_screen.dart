import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/ventas/presentation/providers/detalleVentas_provider.dart';
import 'package:teslo_shop/features/ventas/presentation/providers/providers.dart';

class VentaScreen extends ConsumerStatefulWidget {
  const VentaScreen({super.key});

  @override
  _VentaScreenState createState() => _VentaScreenState();
}

class _VentaScreenState extends ConsumerState {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 400) >=
          scrollController.position.maxScrollExtent) {
        final idVenta = ref.read(ventasProvider).selectedVenta.id;
        print('idVenta');
        print(idVenta);
        ref.read(detalleVentasProvider.notifier).loadNextPage(idVenta);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detalleventasState = ref.watch(detalleVentasProvider);
    final ventas = ref.watch(ventasProvider).selectedVenta;
    print('detalle venta');
    print(detalleventasState.detalleVentas);
    return Scaffold(
      body: ListView(
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Ventas ${ventas.fecha}',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.white)),
                  subtitle: Text(
                      'Total: ${ventas.total} Bs Ganancia: ${ventas.ganancias} Bs',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.white70)),
                  trailing: SizedBox(
                    width: 56,
                    height: 56,
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      elevation: 4,
                      onPressed: () {
                        context.push('/ventaForm');
                      },
                      child: Icon(Icons.add),
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
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DataTable(
                    columns: [
                      DataColumn(
                        label: Text('Cant',
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .primaryColor, //Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text('Tela',
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .primaryColor, //Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text('Precio',
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .primaryColor, //Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                        label: Text('Total',
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .primaryColor, //Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                    columnSpacing: 20,
                    rows: detalleventasState.detalleVentas.map((detalleventa) {
                      return DataRow(cells: [
                        DataCell(Text('${detalleventa.cantidad}mts',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black))),
                        DataCell(Text(detalleventa.nombre,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black))),
                        DataCell(Text('${detalleventa.precio}Bs',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black))),
                        DataCell(
                          Text(
                            '${detalleventa.total}Bs',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
