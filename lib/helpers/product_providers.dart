import 'dart:math';

import 'package:bitshop/helpers/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dio = Dio();
final String server = "http://localhost:8888";

final categoriesProvider = FutureProvider<List<Product>>((ref) async {
  Response response = await dio.get("${server}/products/category-list");
  List<String> categorySlugs = List<String>.from(response.data as List);

  List<Product> products = [];

  await Future.forEach(categorySlugs, (String slug) async {
    try {
      Response response =
          await dio.get("${server}/products/category/$slug?limit=1");
      List<dynamic> categoryProducts = response.data["products"];
      if (categoryProducts.isNotEmpty) {
        final temp = categoryProducts[0] as Map<String, dynamic>;
        Product product =
            Product.fromMap(categoryProducts[0] as Map<String, dynamic>);
        if (![121, 167, 6].contains(product.id)) {
          products = [
            ...products,
            product,
          ];
        }
      }
    } catch (e) {}
  });

  return products;
});

extension StringExtensions on String {
  String toTitleCase() {
    return split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

final productsByCategoryProvider =
    FutureProvider.family<List<Product>?, String>((ref, String slug) async {
  List<Product> products = [];
  Response response = await dio.get("${server}/products/category/$slug");
  List<dynamic> categoryProducts = response.data["products"];
  if (categoryProducts.isNotEmpty) {
    categoryProducts.forEach((value) {
      products.add(Product.fromMap(value));
    });
  }
  return products;
});

final featuredProductsProvider = FutureProvider<List<Product>>((ref) async {
  List<Product> products = [];
  Response response = await dio.get("${server}/products");
  List<dynamic> allProducts = response.data["products"];
  if (allProducts.isNotEmpty) {
    allProducts.forEach((value) {
      try {
        products.add(Product.fromMap(value));
      } catch (e) {}
    });
  }
  products.shuffle(Random());
  return products.take(20).toList();
});

final exploreProductsProvider = FutureProvider<List<Product>>((ref) async {
  List<Product> products = [];
  Response response = await dio.get("${server}/products");
  List<dynamic> allProducts = response.data["products"];
  if (allProducts.isNotEmpty) {
    allProducts.forEach((value) {
      try {
        products.add(Product.fromMap(value));
      } catch (e) {
        print(e);
      }
    });
  }
  products.shuffle(Random());
  return products.take(20).toList();
});

final categorySlugsProvider = FutureProvider<List<String>>((ref) async {
  // Fetch the category slugs from the server
  Response response = await dio.get("${server}/products/category-list");
  List<String> categorySlugs = List<String>.from(response.data as List);

  // Filter valid slugs by checking products for each slug
  List<String> validSlugs = [];
  for (final slug in categorySlugs) {
    try {
      final productsResponse =
          await dio.get("${server}/products/category/$slug");
      // print(("${server}/products?category=$slug"));

      // Handle the response structure appropriately
      final data = productsResponse.data;
      if (data is Map<String, dynamic> && data.containsKey('products')) {
        final products = List.from(data['products']);
        if (products.isNotEmpty) {
          validSlugs.add(slug);
        }
      }
    } catch (e) {
      // Handle errors gracefully (e.g., network issues or unexpected response structure)
      print("Error fetching products for slug $slug: $e");
    }
  }

  return validSlugs;
});

class DetailedProductNotifier extends StateNotifier<Product?> {
  DetailedProductNotifier() : super(null);

  void setDetailedProduct(Product product) {
    state = product;
  }
}

final DeatiledProductProvider =
    StateNotifierProvider<DetailedProductNotifier, Product?>((ref) {
  return DetailedProductNotifier();
});
