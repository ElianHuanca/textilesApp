import 'package:textiles_app/features/auth/domain/domain.dart';

class UsuarioMapper {
  static Usuario userJsonToEntity(Map<String, dynamic> json) => Usuario(
      id: json['id'],
      correo: json['correo'],
      nombre: json['nombre'],
      token: json['token'] ?? '');
}
