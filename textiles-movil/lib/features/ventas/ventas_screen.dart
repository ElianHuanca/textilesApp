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

    final productsState = ref.watch( ventasProvider );
    print(productsState);
    const ventas = [
      {'cantidad': 2, 'tela': 'razo suizo semilicra', 'precio': 30.00},
      {'cantidad': 5, 'tela': 'razo suizo rigido', 'precio': 25.00},
      {'cantidad': 3, 'tela': 'razo 3mts ancho', 'precio': 20.00},
      {'cantidad': 1, 'tela': 'Dipiur 3D', 'precio': 160.00},
      {'cantidad': 2, 'tela': 'razo suizo rigido', 'precio': 25.00},
      {'cantidad': 1, 'tela': 'razo suizo rigido', 'precio': 25.00},
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
                  /* subtitle: Text('Good Morning',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white54)),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/no-image.jpg'), 
                  ),*/
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
              child: ListView(
                //GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                /* crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30, */
                children: [
                  
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
