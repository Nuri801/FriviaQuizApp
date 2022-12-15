import 'package:flutter/material.dart';
import 'package:frivia/assets/colors/constants.dart';
import 'package:frivia/assets/reusable_widgets/custom_button.dart';
import 'package:frivia/controllers/level_controller.dart';
import 'package:frivia/pages/game_page.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  late double deviceHeight;
  late double deviceWidth;

  LevelController controller = Get.put(LevelController());

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
    return GetBuilder<LevelController>(builder: (_) {
      return Column(
        children: [
          const Text(
            "Level: ",
            style: TextStyle(
              fontSize: 30,
              color: kThemeColor,
            ),
          ),
          Text(
            controller.showLevel(controller.levelNum),
            style: TextStyle(
                fontSize: 30,
                color: controller.levelColors[controller.levelNum.toInt() - 1]),
          ),
        ],
      );
    });
  }

  Widget levelSlider() {
    return GetBuilder<LevelController>(builder: (_) {
      return Slider(
        activeColor: controller.levelColors[controller.levelNum.toInt() - 1],
        min: 1,
        max: 3,
        value: controller.levelNum,
        onChanged: (newValue) {
          controller.setLevel(newValue);
        },
        divisions: 2,
        label: controller.showLevel(controller.levelNum),
      );
    });
  }

  Widget startButton() {
    return GetBuilder<LevelController>(builder: (_) {
      return CustomButton(
          height: 100,
          width: deviceWidth * 0.8,
          buttonText: 'Start',
          buttonTextColor: kThemeColor,
          // buttonTextColor: controller.levelColors[controller.levelNum.toInt()-1],
          buttonColor: kBrandColor,
          onPressed: () {
            Get.to(() => GamePage());
          },
          fontSize: 55);
    });
  }
}