import 'package:bitshop/Core/product_listing_widgets.dart';
import 'package:bitshop/helpers/models.dart';
import 'package:bitshop/helpers/product_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Core extends ConsumerWidget {
  const Core({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          CategoriesCarousel(),
        ],
      ),
    ));
  }
}
