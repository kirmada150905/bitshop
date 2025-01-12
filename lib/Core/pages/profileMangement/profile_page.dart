import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitshop/styles/colors.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: darkBlue.withOpacity(0.7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: user?.photoURL != null
                    ? ClipOval(
                        child: Image.network(
                          user!.photoURL!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 80,
                        color: cream,
                      ),
              ),
              const SizedBox(height: 16.0),
              Text(
                user?.displayName ?? "Guest User",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                user?.email ?? "No email available",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 32.0),
              Expanded(
                child: ListView(
                  children: [
                    _buildProfileOption(
                      context,
                      icon: Icons.person_3_outlined,
                      label: "Edit Profile",
                      onTap: () {
                        context.push("/editProfile_page");
                      },
                    ),
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
                      icon: Icons.support_agent_rounded,
                      label: "Customer Support",
                      onTap: () {
                        context.push("/tawkTo_page");
                      },
                    ),
                    _buildProfileOption(
                      context,
                      icon: Icons.logout,
                      label: "Log Out",
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      color: Colors.red,
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

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = const Color.fromRGBO(33, 53, 85, 1),
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
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
                  color: color,
                ),
                const SizedBox(width: 16.0),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                  color: color,
                ),
              ],
            ),
          ),
        ),
        Divider(height: 0.5, color: darkBlue.withOpacity(0.2))
      ],
    );
  }
}
