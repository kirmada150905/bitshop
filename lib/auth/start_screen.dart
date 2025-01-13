import 'package:bitshop/Auth/auth_widgets.dart';
import 'package:bitshop/Auth/createAccount_screen.dart';
import 'package:bitshop/Auth/emailAuth.dart';
import 'package:bitshop/Auth/googleAuth.dart';
import 'package:bitshop/helpers/horizontalORline.dart';
import 'package:bitshop/styles/colors.dart';
import 'package:bitshop/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends ConsumerWidget {
  StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Image.asset("assets/image.png", height: 350),
                SizedBox(height: 50),
                LoginButton(
                  onPressed: () async {},
                  foregroundColor: cream,
                  backgroundColor: darkBlue,
                  text: 'Buy Products',
                ),
                SizedBox(height: 10),
                HorizontalOrLine(label: "OR", height: 2),
                SizedBox(height: 10),
                LoginButton(
                  onPressed: () async {},
                  foregroundColor: cream,
                  backgroundColor: darkBlue,
                  text: "Sell Products",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
