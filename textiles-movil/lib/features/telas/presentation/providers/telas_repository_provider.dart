
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/telas/domain/domain.dart';
import 'package:teslo_shop/features/telas/infrastructure/infrastructure.dart';

final telasRepositoryProvider =Provider<TelasRepository>((ref){
  final telasRepository = TelasRepositoryImpl(
    TelasDataSourceImpl(),
  );
  return telasRepository;
});