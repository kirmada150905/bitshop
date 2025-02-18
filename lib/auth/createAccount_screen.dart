import 'package:bitshop/Auth/auth_widgets.dart';
import 'package:bitshop/Auth/emailAuth.dart';
import 'package:bitshop/Auth/googleAuth.dart';
import 'package:bitshop/Auth/login_screen.dart';
import 'package:bitshop/helpers/horizontalORline.dart';
import 'package:bitshop/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CreateAccountScreen extends ConsumerWidget {
  CreateAccountScreen({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Text(
                  "Create an Account",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Please enter your details to create an account",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: lightBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                LoginField(hint: "Name", controller: _nameController),
                SizedBox(height: 20),
                LoginField(hint: "Email", controller: _emailController),
                SizedBox(height: 20),
                LoginField(hint: "Password", controller: _passController),
                //create account button
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    await emailSignUp(_nameController.text,
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
                  child: Text('Create Account'),
                ),
                SizedBox(height: 20),
                HorizontalOrLine(label: "OR", height: 2),
                SizedBox(height: 20),
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
                        "Sign up with  -  ",
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
                      "Already have an Account? ",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () => context.pop(),
                        child: Text(
                          "Log In",
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
