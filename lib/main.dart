import 'package:flutter/material.dart';
import 'package:tender/login.dart';
import 'package:tender/splash.dart';
import 'dart:async';

void main() => runApp(MyApp());
const colors = Color(0xff0B3A66);
const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xff0B3A66),
    100: const Color(0xff0B3A66),
    200: const Color(0xff0B3A66),
    300: const Color(0xff0B3A66),
    400: const Color(0xff0B3A66),
    500: const Color(0xff0B3A66),
    600: const Color(0xff0B3A66),
    700: const Color(0xff0B3A66),
    800: const Color(0xff0B3A66),
    900: const Color(0xff0B3A66),
  },
);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primaryColor: white,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen()            ,
    );
  }
}