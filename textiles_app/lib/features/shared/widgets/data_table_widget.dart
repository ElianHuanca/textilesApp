// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';

DataTable dataTableWidget(List<String> header, BuildContext context,
    List<DetalleVenta> detalleVentas) {
  return DataTable(
      columns: _columns(header), columnSpacing: 8, rows: _rows(detalleVentas));
}

/* List<DataColumn> _columns(List<String> header) => <DataColumn>[
      header.map((element) => _column(element)).toList(),
      _column('Producto'),
      _column('Cantidad'),
      _column('Precio'),
      _column('Total'),
    ]; */
    
List<DataColumn> _columns(List<String> header) {
  return header.map((title) => _column(title)).toList();
}

DataColumn _column(String texto) => DataColumn(
      label: Text(
        texto,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
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
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
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
