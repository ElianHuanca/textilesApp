class DetalleVenta {
  int? id;
  String? nombre;
  double precio;
  double cantidad;
  double? total;
  int idtelas;

  DetalleVenta(
      {this.id,
      this.nombre,
      required this.precio,
      required this.cantidad,
      this.total,
      required this.idtelas});
}
