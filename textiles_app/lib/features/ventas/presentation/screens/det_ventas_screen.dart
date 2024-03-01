import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/shared/shared.dart';
import 'package:textiles_app/features/ventas/presentation/providers/providers.dart';

class DetVentas extends ConsumerWidget {
  const DetVentas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final venta = ref.watch(ventaProvider).venta;
    final String title = 'Ventas ${venta?.fecha}';
    final String subtitle =
        'Total: ${venta?.total}Bs Ganancias: ${venta?.ganancias}Bs';
    return Screen2(title: title, subtitle: subtitle, widget: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return DataTable(columns: _columns(context), rows: _rows);
  }

  List<DataColumn> _columns(BuildContext context) => <DataColumn>[
        _column(context, 'Producto'),
        _column(context, 'Cantidad'),
        _column(context, 'Precio'),
        _column(context, 'Total'),
      ];

  DataColumn _column(BuildContext context, String texto) => DataColumn(
        label: Text(
          texto,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  List<DataRow> get _rows {

  }
}
