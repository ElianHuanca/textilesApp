

import 'package:textiles_app/features/sucursales/domain/entities/sucursal.dart';

abstract class SucursalesRepository {
  Future<List<Sucursal>> getSucursales(int idusuarios);

}