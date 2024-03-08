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
      ///* Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
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
        path: '/sucursal',
        builder: (context, state) => const SucursalScreen(),
      ),

      GoRoute(
        path: '/telas',
        builder: (context, state) => const TelasScreen(),
      ),

      GoRoute(
        path: '/ventas',
        builder: (context, state) => const VentasScreen(),
      ),

      GoRoute(
        path: '/det_ventas',
        builder: (context, state) => const DetVentas(),
      ),

      GoRoute(
        path: '/det_venta',
        builder: (context, state) => DetVenta(),
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
