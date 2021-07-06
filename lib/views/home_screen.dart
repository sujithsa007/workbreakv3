/// Author : Sujith S A
/// Created on : 27th Apr 2021

/// This is the main screen of the application. It show the clock from clock.dart
/// and also displays options to users to set the work timing and breaks taken in
/// between. The clock theme is also triggered to a new scheme once the user starts working

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:work_break/controllers/clock_controller.dart';
import 'package:work_break/views/clock.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ClockController _clockController = Get.put(ClockController());

  Widget build(BuildContext context) {
    var _mediaQueryHeight = MediaQuery.of(context).size.height;
    var _mediaQueryWidth = MediaQuery.of(context).size.width;
    double _fontSizeTitle = _mediaQueryHeight > 550 ? 18 : 14;
    double _fontSizeSubtitle = _mediaQueryHeight > 550 ? 14 : 10;
    double _fontSizeBullet = _mediaQueryHeight > 550 ? 12 : 8;
    double _fontButton = _mediaQueryHeight > 550 ? 22 : 16;
    double _topMargin = _mediaQueryHeight > 550
        ? _mediaQueryHeight * .01
        : _mediaQueryHeight * .01;

    print(_mediaQueryHeight);

    var _workOptions = <String>[
      "30 mins    ",
      "45 mins    ",
      "60 mins    ",
      "75 mins    ",
      "90 mins    ",
      "105 mins    ",
      "120 mins    ",
      "135 mins    ",
      "150 mins    ",
    ];

    var _intervalOptions = <String>[
      "5 mins    ",
      "10 mins    ",
      "15 mins    ",
      "20 mins    ",
      "25 mins    ",
      "30 mins    ",
      "35 mins    ",
      "40 mins    ",
      "45 mins    ",
    ];

    _onSelectedWorkInterval(selected) {
      _clockController.setIntervalTime = selected;
      if (_clockController.changeInterval == true) {
        _clockController.onToggleValues(_clockController.selectedWorkTime,
            _clockController.selectedWorkInterval);
      }
    }

    _onSelectedWorkTime(String selected) {
      _clockController.setWorkTime = selected;
      if (_clockController.changeInterval == true) {
        _clockController.onToggleValues(_clockController.selectedWorkTime,
            _clockController.selectedWorkInterval);
      }
    }

    // ignore: slash_for_doc_comments
    /**
     * Widgets Used
     */

    TextSpan _headerSpanText(String name, Color color, double fontSize) =>
        TextSpan(
          text: name,
          style: TextStyle(
              fontSize: fontSize, color: color, fontWeight: FontWeight.bold),
        );

    Container _backgroundImage = Container(
      height: _mediaQueryHeight,
      width: _mediaQueryWidth,
      child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset('assets/bgImg.jpg',
              color: Color.fromRGBO(255, 255, 255, 0.9),
              colorBlendMode: BlendMode.modulate)),
    );

    RichText _appBarTitle = RichText(
      text: TextSpan(children: [
        _headerSpanText('W', Colors.white, 30),
        _headerSpanText('O', Colors.white54, 22),
        _headerSpanText('R', Colors.white, 19),
        _headerSpanText('K    ', Colors.white54, 15),
        _headerSpanText('B', Colors.white, 15),
        _headerSpanText('R', Colors.white54, 19),
        _headerSpanText('E', Colors.white, 22),
        _headerSpanText('A', Colors.white54, 26),
        _headerSpanText('K', Colors.white, 31),
      ]),
    );

    Container _optionsContainer(String title, var options, int selector) =>
        Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          width: _mediaQueryWidth * .98,
          padding: EdgeInsets.only(bottom: 5, top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white30,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black87,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0)),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: _mediaQueryWidth,
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: _fontSizeTitle,
                      color: Colors.white70),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  'Scroll for more options-->',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: _fontSizeSubtitle,
                      color: Colors.white70),
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: RadioButtonGroup(
                      labels: options,
                      orientation: GroupedButtonsOrientation.HORIZONTAL,
                      labelStyle: TextStyle(
                          fontSize: _fontSizeBullet, color: Colors.white70),
                      activeColor: Colors.white70,
                      onSelected: (String selected) {
                        selector == 1
                            ? _onSelectedWorkTime(selected)
                            : _onSelectedWorkInterval(selected);
                      }),
                ),
              ),
            ],
          ),
        );

    Container _confirmButton = Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      width: _mediaQueryWidth * .2,
      child: AnimatedOpacity(
        opacity: _clockController.startWorkingTrigger ? 1.0 : 0.0,
        duration: Duration(seconds: 1),
        child: Visibility(
          visible: _clockController.startWorkingTrigger,
          child: ElevatedButton(
            child: Text(
              'Start Working',
              style: TextStyle(color: Colors.black54),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shadowColor: Colors.black,
              splashFactory: InkRipple.splashFactory,
              padding: EdgeInsets.only(top: 20, bottom: 20),
              elevation: 5,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: _fontButton,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: _clockController.changeInterval == true
                ? () async {
                    Future.delayed(const Duration(seconds: 2), () {
                      return null;
                    });
                  }
                : () async {
                    setState(() {});
                    await _clockController.onClickStartWork(
                        _clockController.selectedWorkTime,
                        _clockController.selectedWorkInterval);
                  },
          ),
        ),
      ),
    );

    Container _happyWorkingBanner = Container(
        child: AnimatedContainer(
      margin: EdgeInsets.only(left: 5, right: 5),
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      width: _clockController.startWorkingTrigger ? 0 : _mediaQueryWidth * .7,
      height:
          _clockController.startWorkingTrigger ? 0 : _mediaQueryHeight * .15,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black87,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0)),
        ],
      ),
      duration: const Duration(seconds: 2),
      child: Text(
        'Ensure to take adequate breaks in between and '
        'also stay healthy by eating timely, staying '
        'hydrated and also by stretching a bit.\n\nHappy working!!!',
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _backgroundImage,
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: _appBarTitle,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: ListView(
                children: [
                  Align(
                    child: Container(
                        margin: EdgeInsets.only(top: _topMargin),
                        width: _mediaQueryWidth * .6,
                        height: _mediaQueryWidth * .6,
                        child: ClockScreen()),
                    alignment: Alignment.topCenter,
                  ),
                  _optionsContainer('How long will you work?', _workOptions, 1),
                  SizedBox(
                    height: 10,
                  ),
                  _optionsContainer(
                      'How long will be your break?', _intervalOptions, 2),
                  Platform.isIOS
                      ? SizedBox(
                          height: 50,
                        )
                      : SizedBox(
                          height: 20,
                        ),
                  _confirmButton,
                  _happyWorkingBanner,
                  SizedBox(height: 40),
                ],
              )),
        ],
      ),
    );
  }
}
