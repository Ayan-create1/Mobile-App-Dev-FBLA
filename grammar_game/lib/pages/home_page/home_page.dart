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
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/galaxy.png', // Your background image
              fit: BoxFit.cover, // Make sure the image covers the screen
            ),
          ),
          Center(
            child: Image.asset(
              'assets/Sun_Edited (1).png',
              width: 200,
              height: 200,
            ),
          ),
          Positioned(
            top: 190,
            left: 1,
            child: Image.asset(
              'assets/Saturn.png',
              width: 170,
              height: 170,
            ),
          ),
          Positioned(
            top: 160,
            left: 170,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WordSearchGame(), // Replace with your desired page
                  ),
                );
              },
              child: Image.asset(
                'assets/Uranian Search.png',
                width: 120,
                height: 120,
              ),
            ),
          ),
          Positioned(
            top: 20,
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
            top: 70,
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
    );
  }
}
