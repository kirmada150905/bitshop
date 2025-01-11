import 'package:bitshop/Auth/createAccount_screen.dart';
import 'package:bitshop/Auth/login_screen.dart';
import 'package:bitshop/Base/home_screen.dart';
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
        GoRoute(
          path: '/home_screen',
          builder: (BuildContext context, GoRouterState state) {
            return HomeScreen();
          },
        ),
      ],
    ),
  ],
);
