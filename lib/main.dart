// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_trip_project/views/splash_screen_ui.dart';

void main() {
  runApp( 
    MyTrip()
  );
}

class MyTrip extends StatefulWidget {
  const MyTrip({super.key});

  @override
  State<MyTrip> createState() => _MyTripState();
}

class _MyTripState extends State<MyTrip> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreenUI(),
      theme: ThemeData(
      textTheme: GoogleFonts.kanitTextTheme(
        Theme.of(context).textTheme
      )
        ),
      );
  }
}