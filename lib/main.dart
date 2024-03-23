import 'package:flutter/material.dart';
import 'package:project3_flutter/custom_scroll_behavior.dart';
import 'package:project3_flutter/pages/splash/splash_page.dart';
import 'package:project3_flutter/util/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            centerTitle: true,
            foregroundColor: MyColors.lightColor,
            color: MyColors.primaryColor,
            actionsIconTheme: IconThemeData(
              color: MyColors.lightColor,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => MyColors.primaryColor),
          ))),
      scrollBehavior: MyCustomScrollBehavior(),
      home: const SplashPage(),
    );
  }
}
