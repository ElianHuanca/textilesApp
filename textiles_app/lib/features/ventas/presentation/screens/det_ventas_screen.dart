import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/shared/shared.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import 'package:textiles_app/features/ventas/presentation/providers/providers.dart';

class DetVentas extends ConsumerWidget {
  const DetVentas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detalleVentasState = ref.watch(detalleVentasProvider);
    final venta = ref.watch(ventaProvider).venta;
    final String title = 'Ventas ${venta?.fecha}';
    final String subtitle =
        'Total: ${venta?.total}Bs Ganancias: ${venta?.ganancias}Bs';
    return Screen2(
        title: title,
        subtitle: subtitle,
        dataTable: _buildBody(context, detalleVentasState.detalleVentas));
  }

  DataTable _buildBody(BuildContext context, List<DetalleVenta> detalleVentas) {
    return DataTable(columns: _columns(context), rows: _rows(detalleVentas));
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

  List<DataRow> _rows(List<DetalleVenta> detalleVentas) => <DataRow>[
        for (var det in detalleVentas)
          DataRow(cells: <DataCell>[
            _cell(det.nombre ?? ''),
            _cell('${det.cantidad}mts'),
            _cell('${det.precio}Bs'),
            _cell('${det.total}Bs'),
          ]),
      ];

  DataCell _cell(String texto) => DataCell(
      Text(texto, style: const TextStyle(fontSize: 12, color: Colors.black)));
}
