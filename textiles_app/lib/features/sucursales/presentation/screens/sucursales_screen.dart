import 'package:flutter/material.dart';

class SucursalesScreen extends StatelessWidget {
  const SucursalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sucursales'),
      ),
      body: const Center(
        child: Text('Sucursales Screen'),
      ),
    );
  }
}
