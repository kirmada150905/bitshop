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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Text(
            "Hi, ${user?.displayName?.split(" ")[0].toTitleCase()}",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: darkBlue),
          ),
          Divider(
            height: 2,
            color: Colors.grey,
          ),
          Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
                padding: EdgeInsets.all(20),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Text(
                        "Shop By Categories",
                        style: TextStyle(
                            color: cream,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  CategoriesCarousel(),
                ],
              )),
        ],
      ),
    );
  }
}
