import 'package:flutter/material.dart';
import 'package:frivia/assets/colors/constants.dart';
import 'package:frivia/assets/reusable_widgets/custom_button.dart';
import 'package:frivia/controllers/level_controller.dart';
import 'package:frivia/pages/game_page.dart';
import 'package:get/get.dart';
import '../assets/reusable_widgets/set_number_button.dart';
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
          howManyQuestions(),
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

  Widget howManyQuestions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'How many questions ?',
          style: TextStyle(
            fontSize: 28,
            color: kThemeColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            SetNumberButton(
              height: 50,
              width: 60,
              buttonText: '-',
              buttonTextColor: kThemeColor,
              buttonColor: kBrandColor,
              onPressed: () {
                questionController.setQuestionCount('-');
              },
              fontSize: 25,
            ),
            GetBuilder<QuestionController>(builder: (_) {
              return SizedBox(
                height: 40,
                width: 40,
                child: Center(
                  child: Text(
                    '${questionController.questionCount}',
                    style: kHeader1TextStyle,
                  ),
                ),
              );
            }),
            SetNumberButton(
              height: 50,
              width: 60,
              buttonText: '+',
              buttonTextColor: kThemeColor,
              buttonColor: kBrandColor,
              onPressed: () {
                questionController.setQuestionCount('+');
              },
              fontSize: 25,
            ),
          ],
        ),
      ],
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
    return GetBuilder<LevelController>(
      builder: (_) {
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
      },
    );
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

// class ControlButton2 extends StatelessWidget {
//   ControlButton2({
//     required this.buttonColor,
//     required this.buttonIcon,
//     required this.buttonText,
//     required this.onPress,
//     this.iconColor = Colors.white,
//   });
//
//   final Color buttonColor;
//   final IconData buttonIcon;
//   final String buttonText;
//   final void Function()? onPress;
//   Color iconColor;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(5),
//       child: Container(
//         height: 70,
//         width: 70,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: buttonColor,
//             disabledBackgroundColor: Colors.grey,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//           ),
//           onPressed: onPress,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(3),
//                 child: Icon(
//                   buttonIcon,
//                   color: iconColor,
//                   size: 27,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(3),
//                 child: Text(
//                   textAlign: TextAlign.center,
//                   buttonText,
//                   style: kControlButtonTextStyle,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
