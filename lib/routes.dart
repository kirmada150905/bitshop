import 'package:bitshop/auth/createAccount_screen.dart';
import 'package:bitshop/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LoginScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/createAccount_screen',
          builder: (BuildContext context, GoRouterState state) {
            return CreateAccountScreen();
          },
        ),
      ],
    ),
  ],
);
