import 'package:bitshop/helpers/cart_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitshop/styles/colors.dart';

class CartPage extends ConsumerWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemsAsyncValue = ref.watch(cartItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: TextStyle(color: cream),
        ),
        backgroundColor: darkBlue,
      ),
      body: cartItemsAsyncValue.when(
        data: (cartItems) {
          if (cartItems.isEmpty) {
            return Center(
              child: Text('Your cart is empty!',
                  style: TextStyle(color: darkBlue)),
            );
          }
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(item.thumbnail, fit: BoxFit.cover),
                  ),
                  title: Text(item.title, style: TextStyle(color: darkBlue)),
                  subtitle: Text('\$${item.price}',
                      style: TextStyle(color: Colors.teal)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          ref
                              .read(cartManagerProvider)
                              .updateQuantity(item.id, item.quantity - 1);
                        },
                        color: darkBlue,
                      ),
                      Text('${item.quantity}',
                          style: TextStyle(color: darkBlue)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          ref
                              .read(cartManagerProvider)
                              .updateQuantity(item.id, item.quantity + 1);
                        },
                        color: darkBlue,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          ref.read(cartManagerProvider).removeFromCart(item.id);
                        },
                        color: darkBlue,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error', style: TextStyle(color: Colors.red)),
        ),
      ),
      bottomNavigationBar: cartItemsAsyncValue.when(
        data: (cartItems) {
          final total = cartItems.fold(
            0.0,
            (sum, item) => sum + (item.price * item.quantity),
          );
          return Container(
            padding: const EdgeInsets.all(16.0),
            color: cream,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Proceed to Checkout!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkBlue,
                  ),
                  child: const Text('Checkout'),
                ),
              ],
            ),
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }
}
