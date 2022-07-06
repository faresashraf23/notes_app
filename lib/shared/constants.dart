import 'package:flutter/material.dart';
import 'dart:math';

const Color primaryColor = Color(0xff252525);
var containerColor = Color(0xff3B3B3B);
const titleColor = Color(0xffAEAEAE);
const messageColor = Color(0xffD7D7D7);

const titleTextStyle = FontWeight.w900;
const messageTextStyle = FontWeight.normal;

const titleTextSize = 30.0;
const messageTextSize = 20.0;
List<Color> cardColors = const [
    Color(0xff8253D7),
    Color(0xff00FFAB),
    Color(0xffA91079),
    Color(0xffFABC41),
    Color(0xff044A42),
    Color(0xffFF008E),
    Color(0xff7900FF),
    Color(0xffDDFFBC),
  ];

class CardColor {
  
  static Color getColor(cardColors) {
    int element = Random().nextInt(cardColors.length);
    return cardColors[element];
  }
}
