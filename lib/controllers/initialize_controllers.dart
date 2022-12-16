import 'package:get/get.dart';
import 'level_controller.dart';
import 'question_controller.dart';

Future<void> init() async {
  Get.put(LevelController());
  Get.put(QuestionController());
}