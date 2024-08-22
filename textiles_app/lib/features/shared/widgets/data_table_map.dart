/* // ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/ventas/presentation/providers/providers.dart';
import 'dialogoDeAlerta.dart';

class DataTableMap extends ConsumerWidget {
  final List<Map<String, dynamic>> list;
  final double total;
  final double ?ganancias;
  final double ?descuento;
  final bool detventas;
  const DataTableMap({
    super.key,
    required this.list,
    required this.total,
    this.ganancias,
    required this.detventas,
    this.descuento
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DataTable(
        columns: _columns(context),
        columnSpacing: 8,
        rows: _rows(list, total, ref, context, detventas,ganancias,descuento));
  }
}

List<DataColumn> _columns(BuildContext context) => <DataColumn>[
      _column(context, 'Producto'),
      _column(context, 'Precio'),
      _column(context, 'Cantidad'),
      _column(context, 'Total'),
      _column(context, ''),
    ];

DataColumn _column(BuildContext context, String texto) => DataColumn(
      label: Text(
        texto,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
List<DataRow> _rows(List<Map<String, dynamic>> list, double total,
     WidgetRef ref, BuildContext context, bool detventas,double? ganancias,double? descuento) {
  return list.isEmpty
      ? [
          const DataRow(cells: <DataCell>[
            DataCell(Text('Lista vacía',
                style: TextStyle(fontStyle: FontStyle.italic))),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
          ])
        ]
      : [
          ...list.map((det) {
            return DataRow(cells: <DataCell>[
              _cell(det['nombre'] ?? ''),
              _cell('${det['precio']}Bs'),
              _cell('${det['cantidad']}mts'),
              _cell('${det['total']}Bs'),
              _cellButton(() {
                detventas
                    ? dialogoDeAlerta(context, () {
                        ref
                            .read(detalleVentasProvider.notifier)
                            .deleteDetVenta(det['id']);
                      })
                    : ref
                        .read(detalleVentaFormProvider.notifier)
                        .removeDetalleVenta(
                            det['idtelas'], det['cantidad'], det['precio']);
              })
            ]);
          }).toList(),
          DataRow(cells: <DataCell>[
            _cell(''),
            _cell(''),
            _cellTotal('Total'),
            _cellTotal('$total Bs'),
            _cell(''),
          ]),
          if (ganancias != null) // Agregar las ganancias solo si no son nulas
            DataRow(cells: <DataCell>[
              _cell(''),
              _cell(''),
              _cellTotal('Ganancias'),
              _cellTotal('$ganancias Bs'),
              _cell(''),
            ]),
          if (descuento != null) // Agregar las ganancias solo si no son nulas
            DataRow(cells: <DataCell>[
              _cell(''),
              _cell(''),
              _cellTotal('Descuento'),
              _cellTotal('$descuento Bs'),
              _cell(''),
            ]),
        ];
}

DataCell _cell(String texto) => DataCell(
    Text(texto, style: const TextStyle(fontSize: 12, color: Colors.black)));

DataCell _cellTotal(String texto) => DataCell(Text(texto,
    style: const TextStyle(
        fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold)));

DataCell _cellButton(Function() onTap) => DataCell(
      IconButton(
        padding: EdgeInsets.zero, // Elimina el relleno alrededor del icono
        onPressed: onTap,
        iconSize: 20, // Tamaño más pequeño del icono
        icon: const Icon(Icons.delete_forever_rounded),
      ),
    );
 */