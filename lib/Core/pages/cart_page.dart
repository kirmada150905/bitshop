import 'package:bitshop/helpers/cart_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitshop/styles/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:progress_bar_countdown/progress_bar_countdown.dart';

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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Item removed from cart',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          final cartManager =
                                              ref.read(cartManagerProvider);
                                          cartManager.addToCart(item.copyWith(
                                              quantity: item.quantity));
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                        },
                                        child: Text(
                                          "undo?",
                                          style: TextStyle(
                                            color: cream,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ProgressBarCountdown(
                                    hideText: true,
                                    initialDuration: Duration(seconds: 2),
                                    progressColor: cream,
                                    progressBackgroundColor: darkBlue,
                                    height: 2,
                                    countdownDirection:
                                        ProgressBarCountdownAlignment.left,
                                    controller:
                                        ProgressBarCountdownController(),
                                    autoStart: true,
                                  )
                                ],
                              ),
                              backgroundColor: darkBlue,
                              behavior: SnackBarBehavior.floating,
                              elevation: 20.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              width: MediaQuery.of(context).size.width * 0.8,
                            ),
                          );
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
                    context.push("/checkout_page");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: darkBlue,
                      foregroundColor: cream,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
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
