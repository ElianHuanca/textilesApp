
class Sucursal {
  final int id;
  final String nombre;

  Sucursal({required this.id, required this.nombre});
  factory Sucursal.empty() {
    return Sucursal(
      id: 0,
      nombre: '',      
    );
  }
}
