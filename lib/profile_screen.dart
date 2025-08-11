import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Make status bar transparent so the blue background shows to the top
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.blue, // Match app bar background
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      //  backgroundColor: Colors.blue, // Ensures top background is blue
      body: Stack(
        children: [
          // Blue background
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
          ),

          // Content
          Column(
            children: [
              // Top padding to account for status bar
              SizedBox(height: MediaQuery.of(context).padding.top + 10),

              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Jun',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'avatar@gmail.com',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),

              const SizedBox(height: 20),

              // White card background for menu
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: const [
                      ProfileMenuItem(
                        icon: Icons.shopping_bag,
                        text: 'My Orders',
                      ),
                      ProfileMenuItem(
                        icon: Icons.person,
                        text: 'My Information',
                      ),
                      ProfileMenuItem(
                        icon: Icons.location_on,
                        text: 'Shipping Address',
                      ),
                      ProfileMenuItem(
                        icon: Icons.payment,
                        text: 'Payment Method',
                      ),
                      ProfileMenuItem(
                        icon: Icons.lock,
                        text: 'Change Password',
                      ),
                      ProfileMenuItem(icon: Icons.logout, text: 'Logout'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileMenuItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(text, style: const TextStyle(fontSize: 16)),
      onTap: () {
        // handle navigation
      },
    );
  }
}
