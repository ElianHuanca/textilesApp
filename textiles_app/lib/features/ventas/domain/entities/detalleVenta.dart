// ignore_for_file: file_names

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

  toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'cantidad': cantidad,
      'total': total,
      'idtelas': idtelas
    };
  }
}
