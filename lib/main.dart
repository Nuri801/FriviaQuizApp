import 'package:flutter/material.dart';
import 'package:frivia/assets/colors/constants.dart';
import 'package:frivia/controllers/question_controller.dart';
import 'package:frivia/pages/welcome_page.dart';
import 'package:get/get.dart';
import 'controllers/initialize_controllers.dart' as di;

// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  // QuestionController questionController = Get.find();
  // await questionController.getQuestionFromAPI();
  // questionController.getCurrentQuestionText();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Frivia',
      theme: ThemeData(
        fontFamily: "PatrickHand",
        scaffoldBackgroundColor: kScaffoldColor,
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}