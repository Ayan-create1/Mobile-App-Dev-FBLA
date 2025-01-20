import 'package:flutter/material.dart';
import '../word_search/ui_grid.dart';
import '../drag_and_drop/matching.dart';

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
        child: Column(
          children: [
            ElevatedButton(
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
            ElevatedButton(
              child: Text("Go to Drag and Drop"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DragAndDropGame(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
