import 'package:flutter/material.dart';

class DriverHomescreen extends StatefulWidget {
  const DriverHomescreen({super.key});

  @override
  State<DriverHomescreen> createState() => _DriverHomescreenState();
}

class _DriverHomescreenState extends State<DriverHomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Text("Driver Home Screen")]));
  }
}
