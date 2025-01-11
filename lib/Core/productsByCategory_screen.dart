import 'package:bitshop/Core/product_listing_widgets.dart';
import 'package:bitshop/helpers/product_providers.dart';
import 'package:bitshop/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductsByCategoryScreen extends ConsumerWidget {
  final String categorySlug;

  ProductsByCategoryScreen({super.key, required this.categorySlug});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(productsByCategoryProvider(categorySlug));

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        overlayColor: Colors.white,
                        side: BorderSide(width: 0.5, color: darkBlue),
                        elevation: 2,
                        shadowColor: Colors.white,
                        backgroundColor: darkBlue,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.sort,
                            color: Colors.white,
                          ),
                          Text(
                            "Filters",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    ProductListBuilder(products: products),
                  ],
                ),
              );
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
      ),
    );
  }
}
