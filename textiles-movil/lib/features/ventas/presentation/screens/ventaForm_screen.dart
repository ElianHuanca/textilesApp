// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class VentaFormScreen extends ConsumerStatefulWidget {
  const VentaFormScreen({super.key});

  @override
  _VentaFormScreenState createState() => _VentaFormScreenState();
}

class _VentaFormScreenState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Venta #1'),
            SizedBox(height: 15),
            CustomProductField(
              isTopField: true,
              label: 'Tela',
              keyboardType: TextInputType.text,
              /* onChanged: ref
                  .read(productFormProvider(product).notifier)
                  .onTitleChanged,
              errorMessage: productForm.title.errorMessage, */
            ),
            CustomProductField(
              label: 'Cantidad',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              initialValue: '1',
              /* onChanged: ref
                  .read(productFormProvider(product).notifier)
                  .onTitleChanged,
              errorMessage: productForm.title.errorMessage, */
            ),
            CustomProductField(
              label: 'Precio',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              initialValue: '1',
              /* onChanged: ref.read( productFormProvider(product).notifier).onSlugChanged,
            errorMessage: productForm.slug.errorMessage, */
            ),
          ],
        ));
  }
}
