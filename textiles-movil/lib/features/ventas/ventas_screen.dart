import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/ventas/presentation/providers/ventas_provider.dart';

class VentasScreen extends ConsumerStatefulWidget {
  const VentasScreen({super.key});

  @override
  _VentasScreenState createState() => _VentasScreenState();
}

class _VentasScreenState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final ventasStates = ref.watch(ventasProvider);
    print(ventasStates);

    const ventas = [
      {"id": 2, "fecha": "2023-06-17", "total": 0.0, "ganancias": 0.0},
      {"id": 3, "fecha": "2023-06-21", "total": 0.0, "ganancias": 0.0},
      {"id": 4, "fecha": "2023-06-24", "total": 0.0, "ganancias": 0.0},
      {"id": 5, "fecha": "2023-06-28", "total": 0.0, "ganancias": 0.0},
      {"id": 6, "fecha": "2023-07-01", "total": 0.0, "ganancias": 0.0},
      {"id": 7, "fecha": "2023-07-05", "total": 0.0, "ganancias": 0.0},
      {"id": 8, "fecha": "2023-07-08", "total": 0.0, "ganancias": 0.0},
      {"id": 9, "fecha": "2023-07-12", "total": 0.0, "ganancias": 0.0},
      {"id": 1, "fecha": "2023-06-14", "total": 2553.5, "ganancias": 0.0}
    ];

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
                  title: Text('Ventas',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: //ListView(
                  GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  ...ventas.map((venta) {
                    return (itemDashboard(
                        '${venta['fecha']}',
                        CupertinoIcons.calendar,
                        Colors.deepOrange,
                        '/register'));
                  }).toList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(
          String title, IconData iconData, Color background, String url) =>
      Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            //context.push(url);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  title.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      );
}
