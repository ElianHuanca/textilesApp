import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/menu/menu.dart';
import 'package:teslo_shop/features/ventas/presentation/screens/venta_screen.dart';
import 'package:teslo_shop/features/ventas/ventas.dart';

import 'app_router_notifier.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Primera pantalla
      GoRoute(
        path: '/splash',
        //builder: (context, state) => const CheckAuthStatusScreen(),
        builder: (context, state) => const MenuScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const MenuScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const VentasScreen(),
      ),

      ///* Product Routes
      /* GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ), */
      GoRoute(
        path: '/ventas/:id', // /product/new
        builder: (context, state) => VentaScreen(
          idventas: int.parse(state.params['id'] ?? '0'),
        ),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.subloc;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking)
        return null;

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return '/';
        }
      }

      return null;
    },
  );
});
