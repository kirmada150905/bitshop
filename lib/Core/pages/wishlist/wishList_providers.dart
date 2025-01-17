import 'package:bitshop/Core/pages/wishlist/wishList_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final db = FirebaseFirestore.instance;


class WishlistNotifier extends StateNotifier<List<WishlistItem>> {
  WishlistNotifier() : super([]) {
    _initializeWishlist();
  }

  Future<void> _initializeWishlist() async {
    await fetchWishlist();
  }

  Future<void> fetchWishlist() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User is not logged in");
    }

    final DocumentSnapshot userDoc =
        await db.collection("users").doc(user.uid).get();

    if (userDoc.exists && userDoc.data() != null) {
      final data = userDoc.data() as Map<String, dynamic>;
      if (data["wishlist"] != null && data["wishlist"] is List) {
        final wishlistItems = List<WishlistItem>.from(
          data["wishlist"].map((item) => WishlistItem.fromMap(item)),
        );
        state = wishlistItems;
      }
    } else {
      state = [];
    }
  }

  Future<void> addToWishlist(WishlistItem item) async {
    if (!state.any((wishlistItem) => wishlistItem.id == item.id)) {
      state = [...state, item];
      await _updateWishlistInFirestore();
    }
  }

  Future<void> removeFromWishlist(String itemId) async {
    state = state.where((item) => item.id != itemId).toList();
    await _updateWishlistInFirestore();
  }

  Future<void> _updateWishlistInFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final wishlistData = state.map((item) => item.toMap()).toList();
    await db.collection("users").doc(user.uid).update({"wishlist": wishlistData});
  }
}


final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, List<WishlistItem>>((ref) {
  return WishlistNotifier();
});


