class Tela {
  final int id;
  final String nombre;
  final double precxmen;
  final double precxmay;
  final double precxrollo;
  final double precxcompra;
  final int? idusuarios;

  Tela(
      {required this.precxmen,
      required this.precxmay,
      required this.precxrollo,
      required this.precxcompra,
      this.idusuarios,
      required this.id,
      required this.nombre});
}
