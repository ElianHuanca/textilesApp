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
    return telasState.isLoading
        ? const FullScreenLoader()
        : Screen1(
            backRoute: false,
            widget: _buildBody(telasState.telas, context),
            title: 'Telas',
            isGridview: false,
            onTap: _onTap(context),
          );
  }

  List<Widget> _buildBody(List<Tela> telas, BuildContext context) {
    return telas.map((tela) {
      return _telaCard(tela, context);
    }).toList();
  }

  Container _telaCard(Tela tela, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Theme.of(context).primaryColor.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        title: Text(tela.nombre),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Precio por metro: ${tela.precxmen}Bs'),
            Text('Precio por mayor: ${tela.precxmay}Bs'),
            Text('Precio por rollo: ${tela.precxrollo}Bs'),
            Text('Precio de compra: ${tela.precxcompra}Bs'),
          ],
        ),
        onTap: () {
          context.push('/tela/${tela.id}');
        },
      ),
    );
  }

  Function _onTap(BuildContext context) {
    return () {
      context.push('/tela/0');
    };
  }
}
