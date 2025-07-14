import 'package:flutter/material.dart';
import 'package:mydrive/Screens/rider_panel/Passenger_Screen.dart';
import 'package:mydrive/res/colors.dart';
import 'package:mydrive/widgets/custom_Button.dart';

class DriverAndRider extends StatefulWidget {
  const DriverAndRider({super.key});

  @override
  State<DriverAndRider> createState() => _DriverAndRiderState();
}

class _DriverAndRiderState extends State<DriverAndRider> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Precache images here to avoid MediaQuery error
    precacheImage(const AssetImage('assets/carpng.png'), context);
    precacheImage(const AssetImage('assets/passenger.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGreenLight,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Text(
                "Two Roads",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SeymourOne',
                  color: Colors.black87,
                ),
              ),
              Text(
                "One Journey",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Who Are You Today?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[800],
                ),
              ),

              const SizedBox(height: 28),

              // DRIVER Card
              buildOptionCard(
                imagePath: 'assets/carpng.png',
                buttonText: "DRIVER",
                onTap: () {
                  // TODO: Navigate to driver screen
                },
              ),

              const SizedBox(height: 15),

              // PASSENGER Card
              buildOptionCard(
                imagePath: 'assets/passenger.png',
                buttonText: "PASSENGER",
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => LiveLocationMap(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔁 Reusable Option Card
  Widget buildOptionCard({
    required String imagePath,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [whiteBackground, lightGreen2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: Hero(
              tag: imagePath,
              child: Image.asset(
                imagePath,
                height: 195,
                fit: BoxFit.contain,
                gaplessPlayback: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Custom_button(
              name: buttonText,
              B_color: darkGreen.withOpacity(0.8),
              ontap: onTap,
              b_Width: double.infinity,
              b_height: 40.0,
              textcolor: whiteBackground,
            ),
          ),
        ],
      ),
    );
  }
}
