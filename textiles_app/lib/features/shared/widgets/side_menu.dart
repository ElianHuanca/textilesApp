import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:textiles_app/features/auth/domain/domain.dart';
import 'package:textiles_app/features/auth/presentation/providers/providers.dart';
import 'package:textiles_app/features/shared/shared.dart';

final menuIndexProvider =
    StateNotifierProvider<MenuIndexNotifier, MenuIndexState>(
        (ref) => MenuIndexNotifier());

class MenuIndexNotifier extends StateNotifier<MenuIndexState> {
  MenuIndexNotifier() : super(MenuIndexState());
  void setIndex(int index) {
    state = state.copyWith(index: index);
  }
}

class MenuIndexState {
  final int index;
  MenuIndexState({
    this.index = 1,
  });
  MenuIndexState copyWith({
    int? index,
  }) =>
      MenuIndexState(
        index: index ?? this.index,
      );
}

class SideMenu extends ConsumerWidget {
  final appLinkItems = ['/usuario', '/', '/sucursales', '/telas'];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SideMenu({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;
    final menuIndexState = ref.watch(menuIndexProvider);
    return NavigationDrawer(
        elevation: 1,
        selectedIndex: menuIndexState.index,
        onDestinationSelected: (value){
          ref.read(menuIndexProvider.notifier).setIndex(value);          
          /* if (value == 0) {            
            final Usuario usuario = ref.read(authProvider).usuario!;
            ref.read(loginFormProvider.notifier).cargarUsuario(usuario);
          } */
          //context.push(appLinkItems[value]);
          context.go(appLinkItems[value]);
          scaffoldKey.currentState?.closeDrawer();
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
            child: Text('Saludos', style: textStyles.titleMedium),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
            child: Text(ref.read(authProvider).usuario!.nombre,
                style: textStyles.titleSmall),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.person),
            label: Text('Perfil'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.add_shopping_cart_rounded),
            label: Text('Ventas'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.add_business_rounded),
            label: Text('Sucursales'),
          ),
          const NavigationDrawerDestination(
              icon: Icon(Icons.playlist_add), label: Text('Telas')),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                },
                text: 'Cerrar sesión'),
          ),
        ]);
  }
}
