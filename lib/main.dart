/// Author : Sujith S A
/// Created on : 27th Apr 2021

/// Application entry point

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import 'package:work_break/utilities/color_swatches.dart';
import 'package:work_break/views/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AnimatedSplashScreen splashScreen(
          int dur, String text, nextScreen, Color color) =>
      AnimatedSplashScreen(
          duration: dur,
          splash: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 80,
                fontWeight: FontWeight.bold,
                fontFamily: 'Future'),
          ),
          nextScreen: nextScreen,
          splashTransition: SplashTransition.rotationTransition,
          pageTransitionType: PageTransitionType.bottomToTop,
          backgroundColor: color);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
          primarySwatch: CustomColor.colorCustom,
          fontFamily: '',
        ),
        home: splashScreen(
            750,
            'W O R K ',
            splashScreen(750, 'B R E A K', HomeScreen(), Colors.blue),
            Colors.green));
  }
}
