import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppUser {
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  String? userType;

  AppUser({this.firebaseUser}) {
    fetchUserType();
  }

  bool isSeller() => (userType == "seller");

  void fetchUserType() async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser?.uid)
            .get();

    if (document.exists) {
      print("Document Data: ${document.data()}");
    } else {
      print("No such document!");
    }
  }
}

class AppUserNotifier extends StateNotifier<AppUser> {
  AppUserNotifier() : super(AppUser());
}
