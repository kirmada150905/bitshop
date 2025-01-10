import 'package:bitshop/styles/colors.dart';
import 'package:bitshop/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            LoginField(hint: "email", controller: _emailController),
            LoginField(hint: "password", controller: _passController),
          ],
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
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 20,
          color: lightBlue,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: lightBlue,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: darkBlue,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
