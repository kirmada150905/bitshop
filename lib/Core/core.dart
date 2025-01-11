import 'package:bitshop/Core/pages/base_page.dart';
import 'package:bitshop/Core/pages/explore_page.dart';
import 'package:bitshop/Core/pages/profile_page.dart';
import 'package:bitshop/Core/product_listing_widgets.dart';
import 'package:bitshop/helpers/models.dart';
import 'package:bitshop/helpers/product_providers.dart';
import 'package:bitshop/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Core extends ConsumerStatefulWidget {
  const Core({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CoreState();
}

class _CoreState extends ConsumerState {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [BasePage(), ExplorePage(), ProfilePage()];
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          backgroundColor: cream,
          height: 60,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: darkBlue.withOpacity(0.2),
          selectedIndex: currentPageIndex,
          animationDuration: const Duration(milliseconds: 300),
          destinations: <Widget>[
            NavigationDestination(
              icon: Tooltip(
                message: "Nature",
                child: Icon(
                  Icons.emoji_nature_outlined,
                  size: 28,
                ),
              ),
              label: "Nature",
              selectedIcon: Icon(
                Icons.emoji_nature,
                size: 32,
                color: darkBlue,
              ),
            ),
            NavigationDestination(
              icon: Tooltip(
                message: "Explore",
                child: Icon(
                  Icons.explore_outlined,
                  size: 28,
                ),
              ),
              label: "Explore",
              selectedIcon: Icon(
                Icons.explore,
                size: 32,
                color: darkBlue,
              ),
            ),
            NavigationDestination(
              icon: Tooltip(
                message: "Profile",
                child: Icon(
                  Icons.person_2_outlined,
                  size: 28,
                ),
              ),
              label: "Profile",
              selectedIcon: Icon(
                Icons.person,
                size: 32,
                color: darkBlue,
              ),
            ),
          ],
        ),
        body: SafeArea(child: pages[currentPageIndex]));
  }
}
