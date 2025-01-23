import 'package:flutter/material.dart';
import '../word_search/ui_grid.dart';
import '../drag_and_drop/matching.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/sun.png',
                width: 150,
                height: 150,
              ),
            ),
            Positioned(
              top: 200,
              right: MediaQuery.of(context).size.width / 2 - 90,
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
            Positioned(
              top: 550,
              right: MediaQuery.of(context).size.width / 2 - 90,
              child: ElevatedButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
