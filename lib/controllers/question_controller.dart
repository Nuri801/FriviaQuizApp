import 'dart:convert';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:html_unescape/html_unescape.dart';
import 'level_controller.dart';

class QuestionController extends GetxController {

  LevelController levelController = Get.find();

  int correctAnswers = 0;
  int questionNumber = 0;
  int questionCount = 5;

  final Dio _dio = Dio();

  List? questions;

  Future<void> getQuestionFromAPI() async {
    Response response = await _dio.get(
      'http://opentdb.com/api.php',
      queryParameters: {
        'amount': questionCount,
        'type': 'boolean',
        'difficulty': levelController.showLevel(levelController.levelNum),
      },
    );

    var data = jsonDecode(response.toString(),);
    questions = data["results"];
    update();
  }



  String getCurrentQuestionText() {
    var unescape = HtmlUnescape();
    var question = unescape.convert(questions![questionNumber]["question"]);
    return question;
  }

  void nextQuestion() {
    if (isGameEnd() == true) {
      update();
    } else {
      questionNumber++;
      update();
    }
  }

  bool checkAnswer(String answer) {
    if (questions![questionNumber]["correct_answer"] == answer) {
      correctAnswers++;
      return true;
    } else {
      return false;
    }
  }

  bool isGameEnd() {
    if (questionNumber == questionCount-1) {
      return true;
    } else {
      return false;
    }
  }

  void refreshGame() {
    questionNumber = 0;
    correctAnswers = 0;
    questionCount = 5;
    update();
  }


  void setQuestionCount(String plusMinus) {
    if (questionCount < 9 && plusMinus == '+') {
      questionCount ++;
      update();
    }
    if (questionCount > 3 && plusMinus == '-') {
      questionCount --;
      update();
    }
  }

}

