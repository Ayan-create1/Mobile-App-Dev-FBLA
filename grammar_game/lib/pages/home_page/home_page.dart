import 'package:flutter/material.dart';
import 'package:grammar_game/pages/Login_page/auth_gate.dart';
import 'package:grammar_game/pages/Login_page/auth_service.dart';
import 'package:grammar_game/pages/Login_page/pages/signin_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../word_search/ui_grid.dart';
import '../drag_and_drop/matching.dart';
import 'dart:math';
import '../word_search/pop_up.dart';

//import 'package:shimmer/shimmer.dart';

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Random random = Random();
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int points = 0;
  static final authService = AuthService();
  void logout() async {
    await authService.signOut();
  }

  @override
  void initState() {
    super.initState();
    fetchUserPoints();
  }

  Future<void> fetchUserPoints() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      try {
        final response = await Supabase.instance.client
            .from('profiles')
            .select('points')
            .eq('id', user.id)
            .single();

        setState(() {
          points = response['points'];
        });
      } catch (e) {
        print('Error fetching points: $e');
      }
    }
  }

  Widget build(BuildContext context) {
    List<Color> spaceGradient = [
      Colors.amber[400]!,
      Colors.black,
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
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
              width: screenWidth * 0.55, // Relative to screen width
              height: screenWidth * 0.55, // Maintain aspect ratio
            ),
          ),

          //*Space Words Text
          Positioned(
            top: screenHeight * 0.01, // 10% from top
            left: 0,
            child: SizedBox(
              height: screenHeight * 0.2, // 15% height of the screen
              width: screenWidth,
              child: Image.asset(
                'assets/Space Text (2).png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          //*logout button
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.logout),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: screenWidth * 0.12, // Relative to screen width
              onPressed: () {
                logout();
              },
            ),
          ),

          //*Info button
          Positioned(
            top: 50,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.info),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: screenWidth * 0.12, // Relative to screen width
              onPressed: () {
                iHomePopup(context);
              },
            ),
          ),

          //*Shows Saturn - Faded
          Positioned(
            top: screenHeight * 0.19, // 20% from top
            left: screenWidth * 0.07, // 10% from left
            child: Image.asset(
              'assets/Saturn.png',
              width: screenWidth * 0.4, // 20% of screen width
              height: screenWidth * 0.4, // Maintain aspect ratio
            ),
          ),

          //*Shows Earth - faded
          Positioned(
            top: screenHeight * 0.58, // 50% from top
            left: screenWidth * 0.4, // 35% from left
            child: Image.asset(
              'assets/Earth.png',
              width: screenWidth * 0.23, // Relative to screen width
              height: screenWidth * 0.23, // Maintain aspect ratio
            ),
          ),

          //*Shows Mars - faded
          Positioned(
            top: screenHeight * 0.52, // 46% from top
            left: screenWidth * 0.1, // 5% from left
            child: Image.asset(
              'assets/Mars.png',
              width: screenWidth * 0.27, // Relative to screen width
              height: screenWidth * 0.27, // Maintain aspect ratio
            ),
          ),

          //*Shows Neptune - faded
          Positioned(
            top: screenHeight * 0.27, // 25% from top
            right: screenWidth * 0.05, // 5% from right
            child: Image.asset(
              'assets/Neptune (1).png',
              width: screenWidth * 0.25, // 20% of screen width
              height: screenWidth * 0.25, // Maintain aspect ratio
            ),
          ),

          //*Shows Mercury - faded
          Positioned(
            top: screenHeight * 0.4, // 40% from top
            right: screenWidth * 0.0, // 2% from right
            child: Image.asset(
              'assets/Mercury (1).png',
              width: screenWidth * 0.25, // Relative to screen width
              height: screenWidth * 0.25, // Maintain aspect ratio
            ),
          ),

          //*Shows Venus - faded
          Positioned(
            top: screenHeight * 0.5, // 48% from top
            right: screenWidth * 0.1, // 10% from right
            child: Image.asset(
              'assets/Venus (1).png',
              width: screenWidth * 0.3, // Relative to screen width
              height: screenWidth * 0.35, // Maintain aspect ratio
            ),
          ),

          //*Shows Uranus Real
          Positioned(
            top: screenHeight * 0.2, // 16% from top
            right: screenWidth * 0.27, // 20% from right
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WordSearchGame(), // Replace with your desired page
                  ),
                );
              },
              child: Image.asset(
                'assets/Uranian Search.png',
                width: screenWidth * 0.25, // Relative to screen width
                height: screenWidth * 0.25, // Maintain aspect ratio
              ),
            ),
          ),

          //*Shows Jupiter - Real
          Positioned(
            top: screenHeight * 0.37, // 34% from top
            left: screenWidth * 0.00, // 2% from left
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DragAndDropGame(), // Replace with your desired page
                  ),
                );
              },
              child: Image.asset(
                'assets/Jupiter.png',
                width: screenWidth * 0.25, // Relative to screen width
                height: screenWidth * 0.25, // Maintain aspect ratio
              ),
            ),
          ),

          Positioned(
            bottom: screenHeight * .1,
            right: screenWidth * .1,
            child: Container(
              height: screenHeight * .05,
              width: screenWidth * .8,
              decoration: BoxDecoration(
                color: Colors.black45, // Background color
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: Center(
                child: Text(
                  "Total Points: $points",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
