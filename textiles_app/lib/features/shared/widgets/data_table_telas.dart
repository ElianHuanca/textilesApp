// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataTableMapTelas extends ConsumerWidget {
  final List<Map<String, dynamic>> listbody;
  final List<String> listheader;
  final double total;
  final Function(int,double,double) onTap;
  const DataTableMapTelas({
    super.key,
    required this.listbody,
    required this.listheader,
    required this.total,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DataTable(
        columns: _columns(context, listheader),
        columnSpacing: 8,
        rows: _rows(listbody, total, onTap));
  }
}

List<DataColumn> _columns(BuildContext context, List<String> listheader) =>
    <DataColumn>[
      ...listheader.map((header) => _column(context, header)),
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
    List<Map<String, dynamic>> listbody,double total, Function(int,double,double) onTap) {
  return [
    ...listbody.map((data) {
      return DataRow(cells: <DataCell>[
        _cell('${data['nombre']}'),
        _cell('${data['cantidad']}mts'),
        _cell('${data['precio']}Bs'),
        _cell('${data['total']}Bs'),
        _cellButton(onTap, data['idtelas'], data['cantidad'], data['precio']),        
      ]);
    }).toList(),
    DataRow(cells: <DataCell>[
      _cell(''),
      _cell(''),
      _cell('Total'),
      _cell('$total Bs'),
      _cell(''),
    ])
  ];
}

DataCell _cell(String texto) => DataCell(
    Text(texto, style: const TextStyle(fontSize: 12, color: Colors.black)));

DataCell _cellButton(Function(int,double,double) onTap,int idtelas, double cantidad,double precio) => DataCell(
      IconButton(
        padding: EdgeInsets.zero,
        onPressed: () => onTap(idtelas, cantidad, precio),
        iconSize: 20,
        icon: const Icon(Icons.delete_forever_rounded),
      ),
    );
