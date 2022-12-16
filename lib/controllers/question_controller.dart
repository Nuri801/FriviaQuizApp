import 'dart:convert';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:html_unescape/html_unescape.dart';

class QuestionController extends GetxController {

  int questionNumber = 1;

  final Dio _dio = Dio();

  List? questions;

  Future<void> getQuestionFromAPI() async {
    Response response = await _dio.get(
      'http://opentdb.com/api.php',
      queryParameters: {
        // 'category': 10,
        'amount': 3,
        'type': 'boolean',
        'difficulty': 'easy',
      },
    );
    // print(response);
    var data = jsonDecode(response.toString(),);
    questions = data["results"];
    // print(questions);
    // print('working');
    update();
  }

  String getCurrentQuestionText() {
    var unescape = HtmlUnescape();
    var question = unescape.convert(questions![questionNumber]["question"]);
    // print(question);
    return question;
  }

  void nextQuestion() {
    questionNumber++;
    print(questionNumber);
    update();
  }

}