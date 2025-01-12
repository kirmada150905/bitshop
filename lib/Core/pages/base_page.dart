import 'package:bitshop/Core/product_listing_widgets.dart';
import 'package:bitshop/helpers/product_providers.dart';
import 'package:bitshop/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasePage extends ConsumerWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? user = FirebaseAuth.instance.currentUser;

    return SingleChildScrollView(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Text(
            "Hi, ${user?.displayName?.split(" ")[0].toTitleCase()}",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: darkBlue,
            ),
          ),
          const Divider(
            height: 2,
            color: Colors.grey,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: darkBlue,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListView(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Row(
                  children: [
                    Text(
                      "Shop By Categories",
                      style: TextStyle(
                        color: cream,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                CategoriesCarousel(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Divider(height: 2, color: darkBlue),
          const SizedBox(height: 20),
          Text(
            "Featured for ${user?.displayName?.split(" ")[0].toTitleCase()}",
            style: TextStyle(
              color: darkBlue,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          FeaturedProducts(),
        ],
      ),
    );
  }
}

class FeaturedProducts extends ConsumerWidget {
  const FeaturedProducts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(featuredProductsProvider);
    return asyncValue.when(data: (products) {
      return ProductGridBuilder(products: products);
    }, error: (error, StackTrace) {
      return Container(
        child: Text(error.toString()),
      );
    }, loading: () {
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
