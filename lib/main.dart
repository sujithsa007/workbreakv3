/// Author : Sujith S A
/// Created on : 27th Apr 2021

/// Application entry point

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:work_break/utilities/color_swatches.dart';
import 'package:work_break/views/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: CustomColor.colorCustom,
        fontFamily: '',
      ),
      home: HomeScreen(),
    );
  }
}
