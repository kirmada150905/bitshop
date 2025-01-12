import 'package:bitshop/helpers/cart_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItemsAsyncValue = ref.watch(cartItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: cartItemsAsyncValue.when(
        data: (cartItems) {
          if (cartItems.isEmpty) {
            return const Center(
              child: Text('Your cart is empty!'),
            );
          }
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return ListTile(
                leading: Image.network(item.thumbnail, fit: BoxFit.cover),
                title: Text(item.title),
                subtitle: Text('Price: \$${item.price}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        ref.read(cartManagerProvider).updateQuantity(item.id, item.quantity - 1);
                      },
                    ),
                    Text('${item.quantity}'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        ref.read(cartManagerProvider).updateQuantity(item.id, item.quantity + 1);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ref.read(cartManagerProvider).removeFromCart(item.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
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
            color: Colors.blueGrey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Proceed to Checkout!')),
                    );
                  },
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
