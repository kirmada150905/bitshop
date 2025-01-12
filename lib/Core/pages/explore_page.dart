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
    final categorySlugs = ref.watch(categorySlugsProvider);

    return SafeArea(
      child: categorySlugs.when(
        data: (slugs) {
          if (slugs.isEmpty) {
            return const Center(child: Text("No categories available."));
          }

          final validSlugs = slugs.where((slug) {
            final productsAsyncValue =
                ref.read(productsByCategoryProvider(slug));
            return productsAsyncValue.when(
              data: (products) => products != null && products.isNotEmpty,
              error: (error, stackTrace) => false,
              loading: () => false,
            );
          }).toList();

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      const SizedBox(height: 16.0),
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, child) {
                            final productsAsyncValue =
                                ref.watch(productsByCategoryProvider(slug));

                            return productsAsyncValue.when(
                              data: (products) {
                                return GridView.builder(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio: 1.0,
                                  ),
                                  itemCount: products?.length,
                                  itemBuilder: (context, index) {
                                    final product = products?[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 8.0,
                                            spreadRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: Image.network(
                                          product?.thumbnail ?? "",
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(Icons.image),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              error: (error, stackTrace) =>
                                  const SizedBox.shrink(),
                              loading: () => const SizedBox.shrink(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
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
        error: (error, stackTrace) => const SizedBox.shrink(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
