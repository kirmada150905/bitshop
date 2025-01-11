import 'package:bitshop/helpers/product_providers.dart';
import 'package:bitshop/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesCarousel extends ConsumerWidget {
  const CategoriesCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(categoriesProvider);
    return asyncValue.when(
      data: (categories) {
        return Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.3,
            child: CarouselView(
              itemExtent: MediaQuery.of(context).size.width,
              itemSnapping: true,
              shrinkExtent: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              backgroundColor: cream,
              elevation: 6.0,
              children: categories.map((category) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: cream,
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
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Image.network(
                            category.thumbnail,
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5.0,
                        left: 15.0,
                        right: 15.0,
                        child: Center(
                          child: Text(
                            textScaler: TextScaler.noScaling,
                            category.category.toUpperCase(),
                            style: TextStyle(
                              color: darkBlue,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ));
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(
            'Error: ${error.toString()}',
            style: TextStyle(color: Colors.red),
          ),
        );
      },
      loading: () {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
