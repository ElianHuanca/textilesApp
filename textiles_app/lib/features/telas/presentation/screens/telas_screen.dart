import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:textiles_app/features/shared/shared.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class TelasScreen extends ConsumerWidget {
  const TelasScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telasState = ref.watch(telasProvider);
    return Screen1(
      widget: _buildBody(telasState.telas, context, ref),
      title: 'Telas',
      isGridview: false,
      floatingActionButton: _floatingActionButton(context, ref),
    );
  }

  List<Widget> _buildBody(
      List<Tela> telas, BuildContext context, WidgetRef ref) {
    return telas.map((tela) {
      return _telaCard(tela, context,ref);
    }).toList();
  }

  Card _telaCard(Tela tela, BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Text(tela.nombre),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Precio por metro: ${tela.precxmen}'),
            Text('Precio por mayor: ${tela.precxmay}'),
            Text('Precio por rollo: ${tela.precxrollo}'),
            Text('Precio de compra: ${tela.precxcompra}'),
          ],
        ),
        onTap: () {
          ref.read(telaProvider.notifier).setTela(tela);
          context.go('/tela');
        },
      ),
    );
  }

  FloatingActionButton _floatingActionButton(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      label: const Text('Agregar Tela'),
      onPressed: () {
        ref.read(telaProvider.notifier).nuevaTela();
        context.go('/tela');
      },
      icon: const Icon(Icons.add),
    );
  }
}
