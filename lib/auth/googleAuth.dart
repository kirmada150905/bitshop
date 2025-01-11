import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    EasyLoading.show();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = FirebaseAuth.instance.currentUser;

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
  } catch (e) {
    EasyLoading.showError(e.toString());
    print(e.toString());
  }
}
