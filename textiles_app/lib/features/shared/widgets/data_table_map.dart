// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

DataTable dataTableMap(BuildContext context, List<Map<String, dynamic>> list,double total) {
  return DataTable(
      columns: _columns(context), columnSpacing: 10, rows: _rows(list,total));
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
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
List<DataRow> _rows(List<Map<String, dynamic>> list,double total) {
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
      : [...list.map((det) {
          return DataRow(cells: <DataCell>[
            _cell(det['nombre'] ?? ''),
            _cell('${det['cantidad']}mts'),
            _cell('${det['precio']}Bs'),
            _cell('${det['total']}Bs'),
          ]);
        }).toList(),
        DataRow(cells: <DataCell>[
            _cellTotal('Total'),
            _cell(''),
            _cell(''),
            _cellTotal('$total Bs'),
          ])];
}

DataCell _cell(String texto) => DataCell(
    Text(texto, style: const TextStyle(fontSize: 12, color: Colors.black)));

DataCell _cellTotal(String texto) => DataCell(
    Text(texto, style: const TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold)));  
