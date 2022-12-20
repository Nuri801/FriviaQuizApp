import 'package:frivia/assets/colors/constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LevelController extends GetxController {

  List<String> levelTexts = ['', 'easy', 'medium', 'hard'];

  List<Color> levelColors = [kEasyColor, kMediumColor, kHardColor];

  double levelNum = 2;

  void setLevel(double sliderLevel) {
    levelNum = sliderLevel.toDouble();
    update();
  }

  String showLevel (double levelNum) {
    return levelTexts[levelNum.toInt()];
  }
}