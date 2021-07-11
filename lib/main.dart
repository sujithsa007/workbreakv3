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
  AnimatedSplashScreen splashScreen(int dur, String text, Color color,
          double fontSize, transition, nextScreen) =>
      AnimatedSplashScreen(
          duration: dur,
          splash: Center(
            child: Container(
              height: 500,
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Future'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          nextScreen: nextScreen,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: transition,
          backgroundColor: color);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
          primarySwatch: CustomColor.colorCustom,
          fontFamily: '',
        ),
        home: splashScreen(
            100,
            'W O R K',
            Colors.green,
            80,
            PageTransitionType.rotate,
            splashScreen(
                100,
                'W O R K',
                Colors.deepOrange,
                60,
                PageTransitionType.rotate,
                splashScreen(
                    100,
                    'W O R K',
                    Colors.black,
                    100,
                    PageTransitionType.rotate,
                    splashScreen(
                        100,
                        'W O R K',
                        Colors.amber,
                        50,
                        PageTransitionType.rotate,
                        splashScreen(
                            100,
                            'B R E A K',
                            Colors.blue,
                            30,
                            PageTransitionType.rotate,
                            splashScreen(
                                100,
                                'B R E A K',
                                Colors.red,
                                70,
                                PageTransitionType.rotate,
                                splashScreen(
                                    100,
                                    'B R E A K',
                                    Colors.greenAccent,
                                    100,
                                    PageTransitionType.rotate,
                                    splashScreen(
                                        100,
                                        'B R E A K',
                                        Colors.grey,
                                        70,
                                        PageTransitionType.rotate,
                                        splashScreen(
                                            100,
                                            'W O R K   B R E A K',
                                            Colors.green,
                                            40,
                                            PageTransitionType.fade,
                                            splashScreen(
                                                100,
                                                'W O R K   B R E A K',
                                                Colors.blue,
                                                40,
                                                PageTransitionType.fade,
                                                splashScreen(
                                                    100,
                                                    'W O R K   B R E A K',
                                                    Colors.green,
                                                    40,
                                                    PageTransitionType.fade,
                                                    splashScreen(
                                                        100,
                                                        'W O R K   B R E A K',
                                                        Colors.blue,
                                                        40,
                                                        PageTransitionType.fade,
                                                        HomeScreen())))))))))))));
  }
}
