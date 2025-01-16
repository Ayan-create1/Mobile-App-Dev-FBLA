import 'package:flutter/material.dart';
import 'word_search/ui_grid.dart';

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
      home: WordSearchGame(),
    );
  }
}
