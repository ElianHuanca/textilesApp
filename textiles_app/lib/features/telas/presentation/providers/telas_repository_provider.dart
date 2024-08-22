import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textiles_app/features/auth/presentation/providers/providers.dart';
import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';


final telasRepositoryProvider = Provider<TelasRepository>((ref) {

  final int idusuario = ref.watch(authProvider).usuario!.id ;

  final telasRepository = TelasRepositoryImpl(
    TelasDatasourceImpl(idusuario:idusuario)
  );
  return telasRepository;
});
