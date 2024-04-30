class Venta {
  int id;
  DateTime fecha;
  double total;
  double ganancias;
  double descuento;
  int idsucursales;

  Venta(
      {required this.id,
      required this.fecha,
      required this.total,
      required this.ganancias,
      required this.descuento,
      required this.idsucursales});
}
