import 'package:flutter/material.dart';
import 'package:frivia/assets/colors/constants.dart';
import 'package:frivia/assets/reusable_widgets/custom_button.dart';
import 'package:frivia/controllers/level_controller.dart';
import 'package:frivia/controllers/question_controller.dart';
import 'package:frivia/pages/welcome_page.dart';
import 'package:get/get.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});

  late double deviceHeight;

  late double deviceWidth;

  QuestionController questionController = Get.find();
  LevelController levelController = Get.find();

  WelcomePage welcomePage = WelcomePage();

  @override
  Widget build(BuildContext context) {
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
              Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: GetBuilder<QuestionController>(
                      builder: (_) {
                        return Text(
                          '${questionController.questionNumber + 1}/${questionController.questionCount}',
                          style: TextStyle(
                            fontSize: 25,
                            color: levelController.levelColors[
                                levelController.levelNum.toInt() - 1],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ],
          ),
          questionText(),
          Column(
            children: [
              trueButton(context),
              const SizedBox(
                height: 18,
              ),
              falseButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget returnButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        exitDialog(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: kThemeColor,
        size: 30,
      ),
    );
  }

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
              return GetBuilder<QuestionController>(
                builder: (_) {
                  return Text(
                    textAlign: TextAlign.center,
                    questionController.getCurrentQuestionText(),
                    style: const TextStyle(
                      fontSize: 38,
                      color: kThemeColor,
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: kThemeColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget trueButton(BuildContext context) {
    return CustomButton(
      height: 100,
      width: deviceWidth * 0.8,
      buttonText: 'True',
      buttonTextColor: kThemeColor,
      buttonColor: kTrueColor,
      onPressed: () {
        trueButtonPressed(context);
      },
      fontSize: 45,
    );
  }

  Widget falseButton(BuildContext context) {
    return CustomButton(
      height: 100,
      width: deviceWidth * 0.8,
      buttonText: 'False',
      buttonTextColor: kThemeColor,
      buttonColor: kFalseColor,
      onPressed: () {
        falseButtonPressed(context);
      },
      fontSize: 45,
    );
  }

  void trueButtonPressed(BuildContext context) async {
    showSnackBar(context, 'True');

    await Future.delayed(Duration(milliseconds: 500));

    questionController.isGameEnd()
        ? endGameDialog(context)
        : questionController.nextQuestion();
  }

  void falseButtonPressed(BuildContext context) async {
    showSnackBar(context, 'False');

    await Future.delayed(Duration(milliseconds: 500));

    questionController.isGameEnd()
        ? endGameDialog(context)
        : questionController.nextQuestion();
  }

  Future<void> exitDialog(BuildContext context) {
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
                      questionController.refreshGame();
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

  void showSnackBar(BuildContext context, String buttonAnswer) {
    bool answer = questionController.checkAnswer(buttonAnswer);
    final snackBar = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - deviceHeight * 0.67,
        right: deviceWidth * 0.08,
        left: deviceWidth * 0.08,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: deviceWidth * 0.3),
        child: Icon(
          answer ? Icons.check_circle : Icons.cancel_sharp,
          size: 100,
          color: answer ? kTrueCheckColor : kFalseCheckColor,
        ),
      ),
      duration: const Duration(milliseconds: 200),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> checkerDialog(BuildContext context, String buttonAnswer) {
    bool answer = questionController.checkAnswer(buttonAnswer);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetAnimationDuration: const Duration(milliseconds: 3000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: answer
              ? kTrueCheckerBackgroundColor
              : kFalseCheckerBackgroundColor,
          child: SizedBox(
            height: 300,
            width: 300,
            child: Icon(
              answer ? Icons.check_circle : Icons.cancel_sharp,
              size: 60,
              color: answer ? kTrueCheckColor : kFalseCheckColor,
            ),
          ),
        );
      },
    );
  }

  Future<void> endGameDialog(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: kPopUpColor,
          title: const Text(
            textAlign: TextAlign.center,
            'The End...',
            style: kHeader1TextStyle,
          ),
          content: Text(
            textAlign: TextAlign.center,
            'Score: ${questionController.correctAnswers} / ${questionController.questionCount}',
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
                    buttonText: 'Okay!',
                    buttonTextColor: kThemeColor,
                    buttonColor: kTrueColor,
                    onPressed: () {
                      questionController.refreshGame();
                      Navigator.pop(context);
                      Navigator.pop(context);
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
