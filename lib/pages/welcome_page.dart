import 'package:flutter/material.dart';
import 'package:frivia/assets/colors/constants.dart';
import 'package:frivia/assets/reusable_widgets/custom_button.dart';
import 'package:frivia/controllers/level_controller.dart';
import 'package:frivia/pages/game_page.dart';
import 'package:get/get.dart';
import '../controllers/question_controller.dart';

class WelcomePage extends StatelessWidget {
  late double deviceHeight;
  late double deviceWidth;

  LevelController levelController = Get.find();
  QuestionController questionController = Get.find();

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: welcomeUI(),
      ),
    );
  }

  Widget welcomeUI() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      height: deviceHeight,
      width: deviceWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          gameName(),
          levelText(),
          levelSlider(),
          startButton(),
        ],
      ),
    );
  }

  Widget gameName() {
    return const Text(
      'Frivia',
      style: TextStyle(
        fontSize: 85,
        color: kThemeColor,
      ),
    );
  }

  Widget levelText() {
    return GetBuilder<LevelController>(
      builder: (_) {
        return Column(
          children: [
            const Text(
              "Level :",
              style: TextStyle(
                fontSize: 30,
                color: kThemeColor,
              ),
            ),
            Text(
              levelController.showLevel(levelController.levelNum),
              style: TextStyle(
                  fontSize: 30,
                  color: levelController
                      .levelColors[levelController.levelNum.toInt() - 1]),
            ),
          ],
        );
      },
    );
  }

  Widget levelSlider() {
    return GetBuilder<LevelController>(builder: (_) {
      return Slider(
        activeColor:
            levelController.levelColors[levelController.levelNum.toInt() - 1],
        min: 1,
        max: 3,
        value: levelController.levelNum,
        onChanged: (newValue) {
          levelController.setLevel(newValue);
        },
        divisions: 2,
        label: levelController.showLevel(levelController.levelNum),
      );
    });
  }

  Widget startButton() {
    return GetBuilder<LevelController>(
      builder: (_) {
        return CustomButton(
            height: 100,
            width: deviceWidth * 0.8,
            buttonText: 'Start',
            buttonTextColor: kThemeColor,
            buttonColor: kBrandColor,
            onPressed: () {
              Get.to(() => GamePage());
            },
            fontSize: 55);
      },
    );
  }
}
