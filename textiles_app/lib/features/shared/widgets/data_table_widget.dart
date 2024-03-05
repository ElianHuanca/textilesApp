// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';

DataTable dataTableWidget(
    BuildContext context, List<DetalleVenta> detalleVentas) {
  return DataTable(
      columns: _columns(context),
      columnSpacing: 10,
      rows: _rows(detalleVentas));
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
List<DataRow> _rows(List<DetalleVenta> detalleVentas) {
  return detalleVentas.isEmpty
      ? [
          const DataRow(cells: <DataCell>[
            DataCell(Text('Lista vacía',
                style: TextStyle(fontStyle: FontStyle.italic))),
          ])
        ]
      : detalleVentas.map((det) {
          return DataRow(cells: <DataCell>[
            _cell(det.nombre ?? ''),
            _cell('${det.cantidad}mts'),
            _cell('${det.precio}Bs'),
            _cell('${det.total}Bs'),
          ]);
        }).toList();
}

DataCell _cell(String texto) => DataCell(
    Text(texto, style: const TextStyle(fontSize: 12, color: Colors.black)));
