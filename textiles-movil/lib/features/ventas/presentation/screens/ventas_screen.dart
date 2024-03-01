
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/shared/shared.dart';
import 'package:teslo_shop/features/ventas/domain/domain.dart';
import 'package:teslo_shop/features/ventas/presentation/providers/ventas_provider.dart';
import 'package:go_router/go_router.dart';

class VentasScreen extends ConsumerWidget {
  const VentasScreen({super.key});
  
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ventasState = ref.watch(ventasProvider);    
    return Scaffold(
      body: ventasState.isLoading
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
                      BorderRadius.only(topLeft: Radius.circular(100))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  ...ventasState.ventas
                        .map((venta) => itemDashboard(venta.fecha,
                          Icons.shopping_cart, Colors.blue, venta,context,ref))
                      .toList(),
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
          String title, IconData iconData, Color background, Venta venta,BuildContext context,WidgetRef ref) =>
      Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            ref.read(ventasProvider.notifier).setSelectedVenta(venta);
            context.push('/detalleventas');
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