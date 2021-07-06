/// Author : Sujith S A
/// Created on : 28th Apr 2021

/// This class creates a clock,which shows current device time with seconds shown in clockwise rotational animation.
/// It will be integrated into the main home screen

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:work_break/controllers/clock_controller.dart';

class ClockScreen extends StatelessWidget {
  final ClockController _clockController = Get.put(ClockController());

  @override
  Widget build(BuildContext context) {
    var _mediaQueryHeight = MediaQuery.of(context).size.height;
    var _mediaQueryWidth = MediaQuery.of(context).size.width;
    var _lineWidth = _mediaQueryWidth * .03;
    var _imageWidth = _mediaQueryHeight > 550
        ? _mediaQueryWidth * .35
        : _mediaQueryWidth * .35;

    Center _displayTime(clockController) => Center(
          child: Container(
              // color: Colors.yellow,
              padding: const EdgeInsets.all(36.0),
              width: _mediaQueryWidth * .45,
              height: _mediaQueryWidth * .4,
              child: Center(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: clockController.currentTimeToDisplay,
                      style: TextStyle(
                          fontSize: _mediaQueryHeight > 550 ? 20 : 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' ' + clockController.amPmToDisplay,
                      style: TextStyle(
                          fontSize: _mediaQueryHeight > 550 ? 15 : 9,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
              )),
        );

    Center _clockRing(double radiusMultiplier, bg1, bg2, pc1, pc2) => Center(
          child: CircularPercentIndicator(
            radius: _mediaQueryWidth * radiusMultiplier,
            lineWidth: _lineWidth,
            animation: true,
            percent: _clockController.secondsForAnimation,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: _clockController.clockThemeTrigger ? bg1 : bg2,
            progressColor: _clockController.clockThemeTrigger ? pc1 : pc2,
          ),
        );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() => Container(
              child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.transparent,
                  ),
                ),
              ),
              _displayTime(_clockController),
              _clockRing(
                  0.42, Colors.black, Colors.white, Colors.red, Colors.red),
              _clockRing(0.48, Colors.black, Colors.white, Colors.white,
                  Colors.orangeAccent),
              _clockRing(
                  0.54, Colors.black, Colors.white, Colors.blue, Colors.red),
              _clockController.clockThemeTrigger
                  ? Opacity(
                      opacity: .25,
                      child: Center(
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                          size: _mediaQueryWidth * .35,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                      ),
                    )
                  : Container(),
              _clockController.clockThemeTrigger
                  ? Container()
                  : Opacity(
                      opacity: .25,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                              width: _imageWidth,
                              child: Image.asset('assets/IM.png')),
                        ),
                      ),
                    ),
            ],
          ))),
    );
  }
}
