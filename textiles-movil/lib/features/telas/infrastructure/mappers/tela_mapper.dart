import 'package:teslo_shop/features/telas/domain/domain.dart';

class TelaMapper {
  static jsonToEntity(Map<String, dynamic> json) => Tela(
        id: json['id'],
        nombre: json['nombre'],
      );
}
