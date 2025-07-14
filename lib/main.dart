import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mydrive/Screens/Auth/AuthScreen.dart';
import 'package:mydrive/Screens/driverAndRider/driverAndRider.dart';
import 'package:mydrive/Screens/rider_panel/Passenger_Screen.dart';
import 'package:mydrive/Screens/splashScreen/splashScreen.dart';
import 'package:mydrive/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyDriveApp());
}

class MyDriveApp extends StatefulWidget {
  const MyDriveApp({super.key});

  @override
  State<MyDriveApp> createState() => _MyDriveAppState();
}

class _MyDriveAppState extends State<MyDriveApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LiveLocationMap(),
    );
  }
}
