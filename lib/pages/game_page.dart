import 'package:flutter/material.dart';
import 'package:frivia/assets/colors/constants.dart';
import 'package:frivia/assets/reusable_widgets/custom_button.dart';
import 'package:frivia/controllers/question_controller.dart';
import 'package:frivia/pages/welcome_page.dart';
import 'package:get/get.dart';

class GamePage extends StatelessWidget {
  late double deviceHeight;

  late double deviceWidth;

  QuestionController questionController = Get.find();

  WelcomePage welcomePage = WelcomePage();

  @override
  Widget build(BuildContext context) {
    // questionController.getQuestionFromAPI();

    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: gameUI(context),
      ),
    );
  }

  Widget gameUI(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 42),
      height: deviceHeight,
      width: deviceWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  returnButton(context),
                  const SizedBox(
                    height: 55,
                    width: 30,
                  ),
                ],
              ),
              welcomePage.levelText(),
              const SizedBox(
                height: 30,
                width: 30,
              ),
            ],
          ),
          questionText(),
          Column(
            children: [
              trueButton(),
              const SizedBox(
                height: 18,
              ),
              falseButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget returnButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        _dialogBuilder(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: kThemeColor,
        size: 30,
      ),
    );
  }

  // Widget questionText() {
  //   return FutureBuilder(
  //       future: questionController.getQuestionFromAPI(),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.done) {
  //           return Text(
  //             questionController.getCurrentQuestionText(),
  //             style: const TextStyle(
  //               fontSize: 40,
  //               color: kThemeColor,
  //             ),
  //           );
  //         } else {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //       });
  // }

  Widget questionText() {
    //Use a future builder and circular progress indicator in order to wait for the API to get the questions.
    return Container(
      alignment: Alignment.center,
      height: deviceHeight * 0.45,
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: questionController.getQuestionFromAPI(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(
                  textAlign: TextAlign.center,
                  questionController.getCurrentQuestionText(),
                  style: const TextStyle(
                    fontSize: 38,
                    color: kThemeColor,
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
      ),
    );
  }

  Widget trueButton() {
    return CustomButton(
      height: 100,
      width: deviceWidth * 0.8,
      buttonText: 'True',
      buttonTextColor: kThemeColor,
      buttonColor: kTrueColor,
      onPressed: () {
        questionController.nextQuestion();
      },
      fontSize: 45,
    );
  }

  Widget falseButton() {
    return CustomButton(
      height: 100,
      width: deviceWidth * 0.8,
      buttonText: 'False',
      buttonTextColor: kThemeColor,
      buttonColor: kFalseColor,
      onPressed: () {},
      fontSize: 45,
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: kPopUpColor,
          title: const Text(
            textAlign: TextAlign.center,
            'Sure wanna exit?',
            style: kHeader1TextStyle,
          ),
          content: const Text(
            textAlign: TextAlign.center,
            'Not the end yet...',
            style: kHeader2TextStyle,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    height: 50,
                    width: 80,
                    buttonText: 'No',
                    buttonTextColor: kThemeColor,
                    buttonColor: kTrueColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    fontSize: 20,
                  ),
                  CustomButton(
                    height: 50,
                    width: 80,
                    buttonText: 'Exit',
                    buttonTextColor: kThemeColor,
                    buttonColor: kFalseColor,
                    onPressed: () {
                      Get.to(() => WelcomePage());
                    },
                    fontSize: 20,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
