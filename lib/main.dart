import 'package:bitshop/routes.dart';
import 'package:bitshop/styles/colors.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        primaryColor: darkBlue,
        colorScheme: ColorScheme.fromSeed(seedColor: darkBlue),
      ),
    );
  }
}
