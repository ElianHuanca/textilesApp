import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/shared/shared.dart';
import 'package:teslo_shop/features/telas/domain/domain.dart';
import 'package:teslo_shop/features/telas/presentation/providers/telas_provider.dart';

class TelasScreen extends ConsumerStatefulWidget {
  const TelasScreen({super.key});

  @override
  _TelasScreenState createState() => _TelasScreenState();
}

class _TelasScreenState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
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
                            title: Text('Hello Isela!',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: Colors.white)),
                            subtitle: Text('Good Morning',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white54)),
                          ),
                          const SizedBox(height: 30)
                        ],
                      ),
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      child: Container(
                        //padding: const EdgeInsets.symmetric(horizontal: 30),
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
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: telas.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.amber[600],
          child: Center(
            child: Text(
                'Tela: ${telas[index].nombre}, Precio Mayor: ${telas[index].precxcompra}, Precio Menor: ${telas[index].precxmen}, Precio Compra: ${telas[index].precxcompra}, Precio Rollo: ${telas[index]..precxrollo}'),
          ),
        );
      },
    );
  }
}



/* class _TelasView extends StatelessWidget {
  final BuildContext context;
  final List<Tela> telas;
  const _TelasView({required this.context, required this.telas, super.key});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 40,
      mainAxisSpacing: 30,
      children: [
        ...telas
            .map((tela) => itemDashboard(tela.nombre, Icons.image, Colors.blue))
            .toList()
      ],
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            //context.push(url);
          },
          child: Container(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  title.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      );
} */
