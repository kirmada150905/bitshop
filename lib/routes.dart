import 'package:bitshop/Auth/createAccount_screen.dart';
import 'package:bitshop/Auth/login_screen.dart';
import 'package:bitshop/Core/core.dart';
import 'package:bitshop/Core/pages/checkout_page.dart';
import 'package:bitshop/Core/pages/tawkTo_page.dart';
import 'package:bitshop/Core/pages/detailedProduct_page.dart';
import 'package:bitshop/Core/pages/profileMangement/editProfile_page.dart';
import 'package:bitshop/Core/productsByCategory_screen.dart';
import 'package:bitshop/helpers/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        // return Core();
        return LoginScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/login_screen',
          builder: (BuildContext context, GoRouterState state) {
            return LoginScreen();
          },
        ),
        GoRoute(
          path: '/createAccount_screen',
          builder: (BuildContext context, GoRouterState state) {
            return CreateAccountScreen();
          },
        ),
        GoRoute(
          path: '/core',
          builder: (BuildContext context, GoRouterState state) {
            return Core();
          },
        ),
        GoRoute(
          path: '/productByCategory_screen',
          builder: (BuildContext context, GoRouterState state) {
            final String categorySlug = state.extra as String;
            return ProductsByCategoryScreen(categorySlug: categorySlug);
          },
        ),
        GoRoute(
          path: '/detailedProduct_page',
          builder: (BuildContext context, GoRouterState state) {
            return DetailedProductPage();
          },
        ),
        GoRoute(
          path: '/checkout_page',
          builder: (BuildContext context, GoRouterState state) {
            return CheckoutPage();
          },
        ),
        GoRoute(
          path: '/editProfile_page',
          builder: (BuildContext context, GoRouterState state) {
            return EditProfilePage();
          },
        ),
        GoRoute(
          path: '/tawkTo_page',
          builder: (BuildContext context, GoRouterState state) {
            return TawkToPage();
          },
        ),
      ],
    ),
  ],
);
