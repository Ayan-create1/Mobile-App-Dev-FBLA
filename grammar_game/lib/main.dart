import 'package:flutter/material.dart';
import 'word_search/word_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<String>> grid = test();
    print(grid);
    return MaterialApp();
  }
}
