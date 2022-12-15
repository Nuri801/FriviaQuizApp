import 'package:flutter/material.dart';
import 'package:frivia/assets/colors/constants.dart';
import 'package:frivia/assets/reusable_widgets/custom_button.dart';
import 'package:frivia/pages/welcome_page.dart';
import 'package:get/get.dart';

class GamePage extends StatelessWidget {
  late double deviceHeight;
  late double deviceWidth;

  WelcomePage welcomePage = WelcomePage();

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   foregroundColor: kScaffoldColor,
      //   backgroundColor: kScaffoldColor,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: gameUI(),
      ),
    );
  }

  Widget gameUI() {
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
                  returnButton(),
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

  Widget returnButton() {
    return IconButton(
        onPressed: () {
          Get.to(() => WelcomePage());
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: kThemeColor,
          size: 30,
        ));
  }

  Widget questionText() {
    return Container(
      alignment: Alignment.center,
      height: deviceHeight * 0.45,
      child: SingleChildScrollView(
        child: Text(
          'There is more plastic in the ocean than fish ',
          style: TextStyle(
            fontSize: 40,
            color: kThemeColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget trueButton() {
    return CustomButton(
      height: 100,
      width: deviceWidth * 0.8,
      buttonText: 'true',
      buttonTextColor: kThemeColor,
      buttonColor: kTrueColor,
      onPressed: () {},
      fontSize: 45,
    );
  }

  Widget falseButton() {
    return CustomButton(
      height: 100,
      width: deviceWidth * 0.8,
      buttonText: 'false',
      buttonTextColor: kThemeColor,
      buttonColor: kFalseColor,
      onPressed: () {},
      fontSize: 45,
    );
  }

  // void exitSure() {
  //   showDialog(context: context, builder: builder)
  // }


  
}
