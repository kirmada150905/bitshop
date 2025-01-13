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
                ElevatedButton(
                  onPressed: () async {
                    await emailSignIn(
                        _emailController.text, _passController.text, context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: darkBlue,
                    shadowColor: Colors.grey,
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  ),
                  child: Text('Log In'),
                ),
                SizedBox(height: 10),
                HorizontalOrLine(label: "OR", height: 2),
                SizedBox(height: 10),
                //google login button
                ElevatedButton(
                  onPressed: () async {
                    await signInWithGoogle(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: darkBlue,
                    backgroundColor: cream,
                    shadowColor: Colors.grey,
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Log in with  -  ",
                        style: TextStyle(color: darkBlue),
                      ),
                      SvgPicture.asset("assets/google.svg",
                          width: 35, height: 35),
                    ],
                  ),
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

class LoginField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const LoginField({super.key, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(hint, style: textFieldTextStyle),
        hintText: "enter your $hint",
        hintStyle: TextStyle(
          fontSize: 20,
          color: lightBlue,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: lightBlue,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: darkBlue,
            width: 2,
          ),
        ),
      ),
    );
  }
}
