import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/ventas/presentation/providers/providers.dart';

class VentaScreen extends ConsumerStatefulWidget {
  final int idventas;
  const VentaScreen(this.idventas, {super.key, required int idventas});

  @override
  _VentaScreenState createState() => _VentaScreenState();
}

class _VentaScreenState extends ConsumerState<VentaScreen> {


  @override
  Widget build(BuildContext context) {
    print(widget.idventas);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venta'),
      ),
    );
  }
}
