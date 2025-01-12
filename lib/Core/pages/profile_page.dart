import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitshop/styles/colors.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: cream,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: lightBlue,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture Section
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: lightBlue.withOpacity(0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: cream,
                ),
              ),
              const SizedBox(height: 16.0),
              // Username Section
              Text(
                "John Doe",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: lightBlue,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                "johndoe@example.com",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 32.0),
              // Actions Section
              Expanded(
                child: ListView(
                  children: [
                    _buildProfileOption(
                      context,
                      icon: Icons.shopping_cart,
                      label: "My Orders",
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      context,
                      icon: Icons.favorite,
                      label: "Wishlist",
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      context,
                      icon: Icons.settings,
                      label: "Settings",
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      context,
                      icon: Icons.help,
                      label: "Help & Support",
                      onTap: () {},
                    ),
                    _buildProfileOption(
                      context,
                      icon: Icons.logout,
                      label: "Log Out",
                      onTap: () {
                        // Add logout logic here
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: lightBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24.0,
              color: lightBlue,
            ),
            const SizedBox(width: 16.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.0,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}
