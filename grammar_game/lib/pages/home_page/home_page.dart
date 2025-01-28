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

          //*Paints the Stars
          CustomPaint(
            size: Size.infinite,
            painter: StarPainter(),
          ),

          //*Shows Sun
          Center(
            child: Image.asset(
              'assets/Sun_Edited (1).png',
              width: 200,
              height: 200,
            ),
          ),

          //*Space Words Text
          Positioned(
            child: SizedBox(
              height: 180.0,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/Space Text (2).png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          //*Shows Saturn - Faded
          Positioned(
            top: 190,
            left: 50,
            child: Image.asset(
              'assets/Saturn.png',
              width: 150,
              height: 150,
            ),
          ),

          //*Shows Earth - faded
          Positioned(
            top: 500,
            left: 140,
            child: Image.asset(
              'assets/Earth.png',
              width: 100,
              height: 100,
            ),
          ),

          //*Shows Mars - faded
          Positioned(
            top: 460,
            left: 30,
            child: Image.asset(
              'assets/Mars.png',
              width: 100,
              height: 100,
            ),
          ),

          //*Shows Neptune - faded
          Positioned(
            top: 290,
            right: 30,
            child: Image.asset(
              'assets/Neptune (1).png',
              width: 100,
              height: 100,
            ),
          ),

          //*Shows Mercury - faded
          Positioned(
            top: 400,
            right: 10,
            child: Image.asset(
              'assets/Mercury (1).png',
              width: 100,
              height: 100,
            ),
          ),

          //*Shows Venus - faded
          Positioned(
            top: 480,
            right: 60,
            child: Image.asset(
              'assets/Venus (1).png',
              width: 100,
              height: 100,
            ),
          ),

          //*Shows Uranus Real
          Positioned(
            top: 200,
            right: 110,
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

          //*Shows Jupiter - Real
          Positioned(
            top: 340,
            left: 10,
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
                width: 110,
                height: 110,
              ),
            ),
          ),
          /*
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
          */
        ],
      ),
    );
  }
}
