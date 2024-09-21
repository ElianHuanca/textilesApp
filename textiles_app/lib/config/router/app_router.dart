import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:textiles_app/features/auth/auth.dart';
import 'package:textiles_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:textiles_app/features/sucursales/sucursales.dart';
import 'package:textiles_app/features/telas/telas.dart';
import 'package:textiles_app/features/ventas/ventas.dart';
import 'app_router_notifier.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/usuario',
        builder: (context, state) => const UsuarioScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const SucursalesScreen(
          false,
        ),
      ),
      GoRoute(
        path: '/sucursales',
        builder: (context, state) => const SucursalesScreen(
          true,
        ),
      ),
      GoRoute(
        path: '/sucursal/:idsucursal',
        builder: (context, state) => SucursalScreen(
          id: int.parse(state.pathParameters['idsucursal'].toString()),
        ),
      ),
      GoRoute(
        path: '/telas',
        builder: (context, state) => const TelasScreen(),
      ),
      GoRoute(
        path: '/tela/:idtela',
        builder: (context, state) => TelaScreen(
          id: int.parse(state.pathParameters['idtela'].toString()),
        ),
      ),
      GoRoute(
        path: '/ventas/:idsucursal',
        builder: (context, state) => VentasScreen(
          idsucursal: int.parse(state.pathParameters['idsucursal'].toString()),
        ),
      ),
      GoRoute(
        path: '/det_ventas/:idventa',
        builder: (context, state) => DetVentas(
          idventa: int.parse(state.pathParameters['idventa'].toString()),
        ),
      ),
      GoRoute(
        path: '/det_venta/:idventa',
        builder: (context, state) => DetVenta(
          idventa: int.parse(state.pathParameters['idventa'].toString()),
        ),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

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
