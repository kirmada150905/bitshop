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
    } catch (e) {
      print("Error fetching products for category: ${slug}");
    }
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
