import 'package:flutter/material.dart';
import 'package:textiles_app/features/ventas/domain/domain.dart';
import 'dialogoDeAlerta.dart';

DataTable dataTableWidget(
    List<String> header,
    BuildContext context,
    List<DetalleVenta> detalleVentas,
    double total,
    double ganancias,
    double descuento,
    Function(int) onTap) {
  return DataTable(
      columns: _columns(header),
      columnSpacing: 8,
      rows: _rows(detalleVentas, total, ganancias, descuento, onTap, context));
}

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

List<DataRow> _rows(
    List<DetalleVenta> detalleVentas,
    double total,
    double ganancias,
    double descuento,
    Function(int) onTap,
    BuildContext context) {
  return [
    ...detalleVentas.map((det) {
      return DataRow(cells: <DataCell>[
        _cell(det.nombre!),
        _cell('${det.cantidad}mts'),
        _cell('${det.precio}Bs'),
        _cell('${det.total}Bs'),
        _cellButton(onTap, det.id!, context),
      ]);
    }).toList(),
    DataRow(cells: <DataCell>[
      _cell(''),
      _cell(''),
      _cellBold('Total'),
      _cellBold('$total Bs'),
      _cell(''),
    ]),
    DataRow(cells: <DataCell>[
      _cell(''),
      _cell(''),
      _cellBold('Ganancias'),
      _cellBold('$ganancias Bs'),
      _cell(''),
    ]),
    DataRow(cells: <DataCell>[
      _cell(''),
      _cell(''),
      _cellBold('Descuento'),
      _cellBold('$descuento Bs'),
      _cell(''),
    ]),
  ];
}

DataCell _cell(String texto) => DataCell(
    Text(texto, style: const TextStyle(fontSize: 12, color: Colors.black)));

DataCell _cellBold(String texto) => DataCell(Text(texto,
    style: const TextStyle(
        fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold)));

DataCell _cellButton(Function(int) onTap, int id, BuildContext context) =>
    DataCell(
      IconButton(
        padding: EdgeInsets.zero,
        onPressed: () => dialogoDeAlerta(context, () => onTap(id)),
        iconSize: 20,
        icon: const Icon(Icons.delete_forever_rounded),
      ),
    );
