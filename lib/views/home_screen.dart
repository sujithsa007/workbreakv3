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

    double _opacity = 0.7;

    Color _textColor = _clockController.buttonChange == false
        ? Colors.white70
        : Colors.black87;

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
    }

    _onSelectedWorkTime(String selected) {
      _clockController.setWorkTime = selected;
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
      child: Opacity(
        opacity: 0.9,
        child: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset('assets/bgImg.jpg',
                color: Color.fromRGBO(255, 255, 255, 0.9),
                colorBlendMode: BlendMode.modulate)),
      ),
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
          padding: EdgeInsets.only(bottom: 15, top: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(
                colors: _clockController.buttonChange == false
                    ? [
                        Colors.red.withOpacity(_opacity),
                        Colors.amber.withOpacity(_opacity),
                        Colors.red.withOpacity(_opacity)
                      ]
                    : [Colors.blue, Colors.white, Colors.red]),
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
                      color: _textColor),
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
                      color: _textColor),
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
                          fontSize: _fontSizeBullet, color: _textColor),
                      activeColor: _textColor,
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
      child: DecoratedBox(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: _clockController.buttonChange == false
                    ? [Colors.red, Colors.amber, Colors.red]
                    : [Colors.blue, Colors.white, Colors.red]),
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
        child: ElevatedButton(
          child: Text(
            _clockController.buttonChange == false
                ? 'Start Working'
                : 'Change Timings',
            style: TextStyle(color: _textColor),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.black,
            splashFactory: InkRipple.splashFactory,
            padding: EdgeInsets.only(top: 20, bottom: 20),
            elevation: 5,
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: _fontButton,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () async {
            await _clockController.onClickStartWork(
                _clockController.selectedWorkTime,
                _clockController.selectedWorkInterval);
            setState(() {});
          },
        ),
      ),
    );

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
                  SizedBox(height: 40),
                ],
              )),
        ],
      ),
    );
  }
}
