import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String id;
  final String title;
  final String thumbnail;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.quantity,
  });

  factory CartItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartItem(
      id: doc.id,
      title: data['title'] ?? '',
      thumbnail: data['thumbnail'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      quantity: data['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'thumbnail': thumbnail,
      'price': price,
      'quantity': quantity,
    };
  }
}

class CartManager {

  final String? userId = FirebaseAuth.instance.currentUser?.uid ?? "";
  CartManager();


  CollectionReference get _cartCollection => FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('cart');

  Stream<List<CartItem>> cartStream() {
    return _cartCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CartItem.fromFirestore(doc)).toList();
    });
  }

  Future<void> addToCart(CartItem item) async {
    final docRef = _cartCollection.doc(item.id);
    final existingItem = await docRef.get();

    if (existingItem.exists) {
      final currentQuantity = existingItem['quantity'] ?? 1;
      await docRef.update({'quantity': currentQuantity + item.quantity});
    } else {
      await docRef.set(item.toFirestore());
    }
  }

  Future<void> updateQuantity(String itemId, int quantity) async {
    if (quantity <= 0) {
      await _cartCollection.doc(itemId).delete();
    } else {
      await _cartCollection.doc(itemId).update({'quantity': quantity});
    }
  }

  Future<void> removeFromCart(String itemId) async {
    await _cartCollection.doc(itemId).delete();
  }

  Future<void> clearCart() async {
    final snapshot = await _cartCollection.get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}

final cartManagerProvider = Provider<CartManager>((ref) {
  return CartManager();
});

final cartItemsProvider = StreamProvider<List<CartItem>>((ref) {
  User? user = FirebaseAuth.instance.currentUser;
  final cartManager = ref.watch(cartManagerProvider);
  return cartManager.cartStream();
});
