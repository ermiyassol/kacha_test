import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:kacha_test/features/auth/presentation/screens/login_screen.dart';
import 'package:kacha_test/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:kacha_test/features/exchange/presentation/screens/exchange_screen.dart';
import 'package:kacha_test/features/send_money/presentation/screens/send_money_screen.dart';

enum Routes { login, register, dashboard, sendMoney, exchange }

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/login',
        name: Routes.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      // GoRoute(
      //   path: '/register',
      //   name: Routes.register.name,
      //   builder: (context, state) => const RegisterScreen(),
      // ),
      GoRoute(
        path: '/dashboard',
        name: Routes.dashboard.name,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/send-money',
        name: Routes.sendMoney.name,
        builder: (context, state) => const SendMoneyScreen(),
      ),
      GoRoute(
        path: '/exchange',
        name: Routes.exchange.name,
        builder: (context, state) => const ExchangeScreen(),
      ),
    ],
  );
});
