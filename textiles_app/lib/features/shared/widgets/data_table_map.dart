// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class DataTableMap extends StatelessWidget {
  final List<Map<String, dynamic>> list;
  final double total;
  final double? ganancias;
  const DataTableMap(
      {super.key, required this.list, required this.total, this.ganancias});

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: _columns(context),
        columnSpacing: 8,
        rows: _rows(list, total, ganancias));
  }
}

List<DataColumn> _columns(BuildContext context) => <DataColumn>[
      _column(context, 'Producto'),
      _column(context, 'Precio'),
      _column(context, 'Cantidad'),
      _column(context, 'Total'),
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
List<DataRow> _rows(
    List<Map<String, dynamic>> list, double total, double? ganancias) {
  return list.isEmpty
      ? [
          const DataRow(cells: <DataCell>[
            DataCell(Text('Lista vacía',
                style: TextStyle(fontStyle: FontStyle.italic))),
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
            ]);
          }).toList(),
          DataRow(cells: <DataCell>[
            _cell(''),
            _cell(''),
            _cellTotal('Total'),
            _cellTotal('$total Bs'),
          ]),
          if (ganancias != null) // Agregar las ganancias solo si no son nulas
            DataRow(cells: <DataCell>[
              _cell(''),
              _cell(''),
              _cellTotal('Ganancias'),
              _cellTotal('$ganancias Bs'),
            ]),
        ];
}

DataCell _cell(String texto) => DataCell(
    Text(texto, style: const TextStyle(fontSize: 12, color: Colors.black)));

DataCell _cellTotal(String texto) => DataCell(Text(texto,
    style: const TextStyle(
        fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold)));
