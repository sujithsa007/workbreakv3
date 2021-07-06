/// Author : Sujith S A
/// Created on : 27th Apr 2021

/// A class defined to store custom colors and color related properties

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomColor {

  static final Map<int, Color> color =
  {
    50:Color.fromRGBO(136,14,79, .1),
    100:Color.fromRGBO(136,14,79, .2),
    200:Color.fromRGBO(136,14,79, .3),
    300:Color.fromRGBO(136,14,79, .4),
    400:Color.fromRGBO(136,14,79, .5),
    500:Color.fromRGBO(136,14,79, .6),
    600:Color.fromRGBO(136,14,79, .7),
    700:Color.fromRGBO(136,14,79, .8),
    800:Color.fromRGBO(136,14,79, .9),
    900:Color.fromRGBO(136,14,79, 1),
  };

  static final MaterialColor colorCustom = MaterialColor(0xFFFFFFFF, color);
}
