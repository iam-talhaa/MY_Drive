import 'package:flutter/material.dart';
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
    // TODO: implement initState
    super.initState();

    Splashservices _splashservices = Splashservices();
    //_splashservices.Login(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkText,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(height: 100, width: 100, image: AssetImage('assets/tire.png')),
          Center(
            child: Text(
              'MyDrive',
              style: TextStyle(
                fontSize: 30,
                color: lightGreen,
                fontFamily: 'SeymourOne',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
