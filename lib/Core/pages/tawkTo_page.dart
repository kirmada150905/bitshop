import 'package:bitshop/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';

class TawkToPage extends StatefulWidget {
  const TawkToPage({super.key});

  @override
  _TawkToPageState createState() => _TawkToPageState();
}

class _TawkToPageState extends State<TawkToPage> {
  bool isTawkInitialized = false;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: darkBlue),
          title: Text(
            "Customer Support",
            style: TextStyle(
                color: darkBlue, fontWeight: FontWeight.w600, letterSpacing: 2),
          ),
          backgroundColor: cream,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Tawk(
            directChatLink:
                'https://tawk.to/chat/677cf12baf5bfec1dbe7c15c/1ih00s54f',
            visitor: TawkVisitor(
              name: user?.displayName,
              email: user?.email,
            ),
          ),
        ));
  }
}
