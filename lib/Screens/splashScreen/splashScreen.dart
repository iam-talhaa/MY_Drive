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
      backgroundColor: greenBackground,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Green glow around Lottie
              Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      primaryGreen2.withOpacity(0.3),
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
              Text(
                'MyDrive',
                style: TextStyle(
                  fontSize: 36,
                  color: primaryGreen,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  fontFamily: 'SeymourOne',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Smart, Simple, Safe.',
                style: TextStyle(
                  fontSize: 16,
                  color: greenText,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
