import 'package:flutter/material.dart';
import 'package:grammar_game/pages/home_page/home_page.dart';
//import 'pages/word_search/ui_grid.dart';
//! Implement a feature that only allows horizontal or vertical path
//! Implement a word box to fill bottom half of screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grammar Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
        ),
        //! Research useMaterial3
        useMaterial3: true,
        //Here we are giving the app bar colors and a fontSize and fontWeight
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
