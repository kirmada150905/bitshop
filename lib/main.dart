import 'package:bitshop/routes.dart';
import 'package:bitshop/styles/colors.dart';
import 'package:bitshop/styles/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureEasyLoading();
  runApp(MyApp());
}

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
      builder: EasyLoading.init(),
    );
  }
}
