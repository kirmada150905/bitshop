import 'package:bitshop/Auth/auth_widgets.dart';
import 'package:bitshop/Auth/emailAuth.dart';
import 'package:bitshop/Auth/googleAuth.dart';
import 'package:bitshop/helpers/horizontalORline.dart';
import 'package:bitshop/styles/colors.dart';
import 'package:bitshop/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _emailController.text = "mohan.krishna.dt@gmail.com";
    _passController.text = "password";
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
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Please log in to your account",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: lightBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                LoginField(hint: "email", controller: _emailController),
                SizedBox(height: 20),
                LoginField(hint: "Password", controller: _passController),
                SizedBox(height: 30),
                //email login button
                LoginButton(
                  onPressed: () async {
                    await emailSignIn(
                        _emailController.text, _passController.text, context);
                  },
                  foregroundColor: Colors.white,
                  backgroundColor: darkBlue,
                  text: 'Log in',
                ),
                SizedBox(height: 10),
                HorizontalOrLine(label: "OR", height: 2),
                SizedBox(height: 10),
                //google login button
                LoginButton(
                  onPressed: () async {
                    await signInWithGoogle(context);
                  },
                  backgroundColor: cream,
                  foregroundColor: darkBlue,
                  text: "Log in with  -  ",
                  svgPath: "assets/google.svg",
                  verticalPadding: 10,
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Don't have an Account? ",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          context.push('/createAccount_screen');
                        },
                        child: Text(
                          "Create One",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
