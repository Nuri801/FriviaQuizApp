import 'package:flutter/material.dart';
import 'package:frivia/assets/colors/constants.dart';
import 'package:frivia/pages/welcome_page.dart';
import 'package:get/get.dart';

void main() {
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
