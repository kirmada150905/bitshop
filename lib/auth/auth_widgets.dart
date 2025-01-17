import 'package:bitshop/Auth/googleAuth.dart';
import 'package:bitshop/styles/colors.dart';
import 'package:bitshop/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  Icon? icon;
  bool? obscure;
  LoginField({
    super.key,
    required this.hint,
    required this.controller,
    this.obscure,
    this.icon,
  });

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

class LoginButton extends StatelessWidget {
  VoidCallback? onPressed;
  Color backgroundColor;
  Color foregroundColor;
  String text;
  Color? textColor = Colors.white;
  String? svgPath;
  double? verticalPadding;

  LoginButton({
    super.key,
    required this.onPressed,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.text,
    this.textColor,
    this.svgPath,
    this.verticalPadding
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        shadowColor: Colors.grey,
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: verticalPadding ?? 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: textColor),
          ),
          svgPath != null
              ? SvgPicture.asset(svgPath ?? "", width: 35, height: 35)
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
