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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreenLight,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
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

              Text(
                "Who Are You Today?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[800],
                ),
              ),

              // DRIVER Card
              buildOptionCard(
                imagePath: 'assets/carpng.png',
                buttonText: "DRIVER",
                onTap: () {
                  // Navigate or do something
                },
              ),

              SizedBox(height: 20),

              // PASSENGER Card
              buildOptionCard(
                imagePath: 'assets/passenger.png',
                buttonText: "PASSENGER",
                onTap: () {
                  // Navigate or do somethingn
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

  // Reusable Styled Card
  Widget buildOptionCard({
    required String imagePath,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 240,
      width: double.infinity,

      padding: EdgeInsets.symmetric(vertical: 0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Hero(
              tag: imagePath,
              child: Image.asset(imagePath, height: 195, fit: BoxFit.contain),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 5),
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
