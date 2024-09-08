import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:stayez/custom_naviation.dart';
import 'package:stayez/splashscrren.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: SplashScreen(),

    );
  }
}