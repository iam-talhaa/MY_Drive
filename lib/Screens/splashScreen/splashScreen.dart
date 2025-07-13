import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mydrive/res/colors.dart';
import 'package:mydrive/services/splashServices.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
   Splashservices().Login(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEEEEEE), // Light Grey
              Color(0xFFDADADA), // Slightly Darker Grey
              Color(0xFFCFCFCF), // Medium Grey
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Glowing circle behind Lottie
                Container(
                  height: 240,
                  width: 240,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryGreen2.withOpacity(0.5),
                        blurRadius: 50,
                        spreadRadius: 10,
                      ),
                    ],
                    gradient: RadialGradient(
                      colors: [
                        primaryGreen2.withOpacity(0.35),
                        Colors.transparent,
                      ],
                      radius: 0.8,
                    ),
                  ),
                  child: Lottie.asset(
                    'assets/location.json',
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 30),

                // App Title
                Text(
                  'MyDrive',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                    letterSpacing: 1.2,
                    fontFamily: 'SeymourOne', // Make sure this font exists
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: primaryGreen2.withOpacity(0.6),
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Tagline
                Text(
                  'Smart, Simple, Safe.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
