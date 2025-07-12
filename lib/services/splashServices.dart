import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mydrive/Screens/Auth/AuthScreen.dart';

class Splashservices {
  void Login(context) {
    Timer(Duration(seconds: 04), () {
      // Navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()),
      );
    });
  }
}
