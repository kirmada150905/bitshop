import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

Future<void> emailSignIn(
    String emailAddress, String password, BuildContext context) async {
  try {
    EasyLoading.show();
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    User? user = FirebaseAuth.instance.currentUser;
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    if (!userDoc.exists) {
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'name': user?.displayName,
        'email': user?.email,
        'uid': user?.uid,
      });
    }
    context.go("/core");
    EasyLoading.dismiss();
  } on FirebaseAuthException catch (e) {
    EasyLoading.dismiss();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(e.toString()),
      backgroundColor: Colors.red,
    ));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An unexpected error occurred. Please try again.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<void> emailSignUp(String name, String emailAddress, String password,
    BuildContext context) async {
  try {
    EasyLoading.show();
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateProfile(displayName: name);
      await user.reload();
      user = FirebaseAuth.instance.currentUser;
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    if (!userDoc.exists) {
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'name': user?.displayName,
        'email': user?.email,
        'uid': user?.uid,
      });
    }

    context.go("/core");
    EasyLoading.dismiss();
  } on FirebaseAuthException catch (e) {
    EasyLoading.dismiss();
    EasyLoading.showError(e.message ?? "An error occurred");
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('The password provided is too weak.'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('The account already exists for that email.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    EasyLoading.dismiss();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An unexpected error occurred. Please try again.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
