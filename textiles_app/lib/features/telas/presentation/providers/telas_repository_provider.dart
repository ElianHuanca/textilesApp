import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/auth/presentation/providers/providers.dart';
import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';


final telasRepositoryProvider = Provider<TelasRepository>((ref) {

  final int idusuario = ref.read(authProvider).usuario!.id;//ref.watch(authProvider).usuario!.id ;

  return TelasRepositoryImpl(
    TelasDatasourceImpl(idusuario:idusuario)
  );
  
});
