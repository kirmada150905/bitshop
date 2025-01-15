import 'package:bitshop/Core/product_listing_widgets.dart';
import 'package:bitshop/helpers/product_providers.dart';
import 'package:bitshop/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for `AutomaticKeepAliveClientMixin`

    final categorySlugsAsync = ref.watch(categorySlugsProvider);

    return SafeArea(
      child: categorySlugsAsync.when(
        data: (validSlugs) {
          if (validSlugs.isEmpty) {
            return const Center(
              child: Text(
                "No valid categories or products available.",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return CarouselSlider.builder(
            itemCount: validSlugs.length,
            itemBuilder: (context, index, realIndex) {
              final slug = validSlugs[index];
              final asyncValue = ref.watch(productsByCategoryProvider(slug));
              return asyncValue.when(
                data: (products) {
                  return GestureDetector(
                    onTap: () {
                      context.push("/productByCategory_screen", extra: slug);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: lightBlue,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Text(
                            slug.toUpperCase(),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              color: cream,
                            ),
                          ),
                          ProductGridBuilder(products: products!),
                        ],
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return Center(child: Text("Error loading category $slug."));
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.8,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              autoPlay: false,
            ),
          );
        },
        error: (error, stackTrace) =>
            const Center(child: Text("Error loading categories.")),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
