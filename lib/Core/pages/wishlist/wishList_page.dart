import 'package:bitshop/Core/pages/wishlist/wishList_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist"),
        automaticallyImplyLeading: false,
      ),
      body: wishlist.isEmpty
          ? Center(child: Text("Your wishlist is empty"))
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final item = wishlist[index];
                return ListTile(
                  leading: Image.network(item.image),
                  title: Text(item.title),
                  subtitle: Text("\$${item.price}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      ref
                          .read(wishlistProvider.notifier)
                          .removeFromWishlist(item.id);
                    },
                  ),
                );
              },
            ),
    );
  }
}
