import 'package:flutter/material.dart';
import '../word_search/ui_grid.dart';
import '../drag_and_drop/matching.dart';
import 'dart:math';
//import 'package:shimmer/shimmer.dart';

class StarPainter extends CustomPainter {
  final Random random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    // ignore: deprecated_member_use
    final paint = Paint()..color = Colors.white.withOpacity(0.7);
    for (int i = 0; i < 200; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2;
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> spaceGradient = [
      Colors.amber[400]!,

      //Colors.deepOrange[800]!,
      Colors.black,
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: spaceGradient,
                  radius: 0.3,
                ),
              ),
            ),
          ),
          CustomPaint(
            size: Size.infinite,
            painter: StarPainter(),
          ),
          Center(
            child: Image.asset(
              'assets/Sun_Edited (1).png',
              width: 200,
              height: 200,
            ),
          ),
          Positioned(
            top: 100,
            left: 120,
            child: Image.asset(
              'assets/Saturn.png',
              width: 200,
              height: 200,
            ),
          ),
          Positioned(
            top: 200,
            right: 30,
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
                width: 100,
                height: 100,
              ),
            ),
          ),
          Positioned(
            top: 190,
            left: 1,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DragAndDropGame(), // Replace with your desired page
                  ),
                );
              },
              child: Image.asset(
                'assets/Jupiter.png',
                width: 130,
                height: 130,
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
