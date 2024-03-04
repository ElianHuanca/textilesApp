import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';


final telasRepositoryProvider = Provider<TelasRepository>((ref) {
  final telasRepository = TelasRepositoryImpl(
    TelasDatasourceImpl()
  );
  return telasRepository;
});
