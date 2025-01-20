import 'package:flutter/material.dart';
import '../word_search/ui_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
            child: Text("Go to Word Search"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WordSearchGame(),
                ),
              );
            },
          ),
      ),
    );
  }
}
