import 'package:flutter/material.dart';
import 'package:textiles_app/features/shared/shared.dart';

class SucursalesScreen extends StatelessWidget {
  const SucursalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen1(widget: _buildBody(), title: 'Sucursales');
  }

  Widget _buildBody() {
    return const Center(
      child: Text('Sucursales Body'),
    );
  }
}
