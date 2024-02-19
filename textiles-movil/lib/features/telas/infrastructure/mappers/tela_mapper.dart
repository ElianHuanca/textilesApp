import 'package:teslo_shop/features/telas/domain/domain.dart';

class TelaMapper {
  static jsonToEntity(Map<String, dynamic> json) => Tela(
        id: json['id'],
        nombre: json['nombre'], 
        precxmay: double.parse( json['precxmay'].toString() ), 
        precxmen: double.parse( json['precxmen'].toString() ), 
        precxrollo: double.parse( json['precxrollo'].toString() ),
        precxcompra: double.parse( json['precxcompra'].toString() ), 
      );
}
