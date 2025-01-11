import 'package:bitshop/Core/product_listing_widgets.dart';
import 'package:bitshop/helpers/product_providers.dart';
import 'package:bitshop/styles/colors.dart'; // Assuming you have a color palette file
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsByCategoryScreen extends ConsumerWidget {
  final String categorySlug;

  ProductsByCategoryScreen({super.key, required this.categorySlug});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(productsByCategoryProvider(categorySlug));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categorySlug.toUpperCase(),
          style: TextStyle(
            color: darkBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: cream,
        iconTheme: IconThemeData(color: darkBlue),
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: asyncValue.when(
          data: (products) {
            if (products == null || products.isEmpty) {
              return Center(
                child: Text(
                  'No products found!',
                  style: TextStyle(
                    color: lightBlue,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }

            return SingleChildScrollView(
                child: ProductListBuilder(products: products));
          },
          error: (error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 50.0,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Failed to load products',
                    style: TextStyle(
                      color: darkBlue,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () =>
                        ref.refresh(productsByCategoryProvider(categorySlug)),
                    icon: Icon(Icons.refresh, color: cream),
                    label: Text(
                      'Retry',
                      style: TextStyle(color: cream),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => Center(
            child: CircularProgressIndicator(
              color: darkBlue,
            ),
          ),
        ),
      ),
    );
  }
}
