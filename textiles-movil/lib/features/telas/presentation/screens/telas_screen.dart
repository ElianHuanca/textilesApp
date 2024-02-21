import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/shared/shared.dart';
import 'package:teslo_shop/features/telas/domain/domain.dart';
import 'package:teslo_shop/features/telas/presentation/providers/telas_provider.dart';

class TelasScreen extends ConsumerWidget {
  const TelasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telaState = ref.watch(telasProvider);
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: telaState.isLoading
              ? const FullScreenLoader()
              : ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 30),
                            title: Text('Telas',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: Colors.white)),
                          ),
                          const SizedBox(height: 30)
                        ],
                      ),
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100))),
                        child: _TelasView(
                            telas: telaState.telas, context: context),
                      ),
                    ),
                  ],
                ),
        ));
  }
}

class _TelasView extends StatelessWidget {
  final BuildContext context;
  final List<Tela> telas;
  const _TelasView({required this.context, required this.telas, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: telas.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          //padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#${telas[index].id} ${telas[index].nombre}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text('Precio Menor: ${telas[index].precxmen}'),
                Text('Precio Mayor: ${telas[index].precxmay}'),                
                Text('Precio Compra: ${telas[index].precxcompra}'),
                Text('Precio Rollo: ${telas[index].precxrollo}')
              ],
            ),
          ),
        );
      },
    );
  }
}

