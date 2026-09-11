import 'package:flutter/material.dart';
import 'package:grammar_game/pages/Login_page/auth_gate.dart';
import 'package:grammar_game/pages/Login_page/auth_service.dart';
import 'package:grammar_game/pages/shop/tiles/shop_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../word_search/ui_grid.dart';
import '../drag_and_drop/matching.dart';
import 'dart:math';
import '../word_search/pop_up.dart';
import 'dart:async';
import '../chat_gpt/chat_page.dart';
import '../shop/tiles/shop_service.dart';
import '../shop/tiles/tile_preferences.dart';

// Custom Painter for the starry background
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
  int total_points = 0;
  static final authService = AuthService();
  final ShopService _shopService = ShopService();
  TileSkin? _selectedSkin;
  /*
  void logout() async {
    await authService.signOut();
  }
*/
  Future<void> logout() async {
    try {
      await authService.signOut();
    } catch (e) {
      print('Logout error: $e');
      // You might want to show an error message to the user here
    }
  }

  final Random _random = Random();

  // Rocket and punctuation positions and velocities
  late double _rocketX, _rocketY, _rocketDX, _rocketDY;
  late List<double> _punctuationX,
      _punctuationY,
      _punctuationDX,
      _punctuationDY;

  // Floating punctuation marks
  final List<String> _punctuationMarks = [':', ';', ',', '.', '!', '?'];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchUserPoints();
    _initializePositions();
    _startFloatingAnimation();
    _loadSelectedSkin();
  }

  void _initializePositions() {
    _rocketX = 0.5;
    _rocketY = 0.5;
    _rocketDX = _randomVelocity();
    _rocketDY = _randomVelocity();

    _punctuationX =
        List.generate(_punctuationMarks.length, (_) => _random.nextDouble());
    _punctuationY =
        List.generate(_punctuationMarks.length, (_) => _random.nextDouble());
    _punctuationDX =
        List.generate(_punctuationMarks.length, (_) => _randomVelocity());
    _punctuationDY =
        List.generate(_punctuationMarks.length, (_) => _randomVelocity());
  }

  double _randomVelocity() {
    return (_random.nextDouble() * 0.007 + 0.003) *
        (_random.nextBool() ? 1 : -1);
  }

  void _startFloatingAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        // Update rocket position
        _rocketX += _rocketDX;
        _rocketY += _rocketDY;

        if (_rocketX < -0.2 || _rocketX > 1.2) _rocketDX = -_rocketDX;
        if (_rocketY < -0.2 || _rocketY > 1.2) _rocketDY = -_rocketDY;

        // Update punctuation positions
        for (int i = 0; i < _punctuationMarks.length; i++) {
          _punctuationX[i] += _punctuationDX[i];
          _punctuationY[i] += _punctuationDY[i];

          if (_punctuationX[i] < -0.2 || _punctuationX[i] > 1.2)
            _punctuationDX[i] = -_punctuationDX[i];
          if (_punctuationY[i] < -0.2 || _punctuationY[i] > 1.2)
            _punctuationDY[i] = -_punctuationDY[i];
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _loadSelectedSkin() async {
    try {
      final skin = await _shopService.getSelectedSkin();
      setState(() {
        _selectedSkin = skin;
      });
    } catch (e) {
      print('Error loading selected skin: $e');
    }
  }

  Future<void> fetchUserPoints() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      try {
        final response = await Supabase.instance.client
            .from('profiles')
            .select('points, total_points')
            .eq('id', user.id)
            .maybeSingle();
        if (response != null) {
          setState(() {
            points = response['points'] ?? 0;
            total_points = response['total_points'] ?? 0;
          });
        } else {
          print('No profile found');
          await Supabase.instance.client.from('profiles').insert({
            'id': user.id,
            'points': 0,
            'total_points': 0,
            'username': user.email,
          });
        }
      } catch (e) {
        print('Error fetching points: $e');
      }
    }
  }

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List<Color> spaceGradient = [
      Colors.amber[400]!,
      Colors.black,
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          // Background gradient
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

          // Paint stars
          CustomPaint(
            size: Size.infinite,
            painter: StarPainter(),
          ),

          // Floating punctuation marks
          for (int i = 0; i < _punctuationMarks.length; i++)
            Positioned(
              left: _punctuationX[i] * screenWidth,
              top: _punctuationY[i] * screenHeight,
              child: Text(
                _punctuationMarks[i],
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          // Flying rocket
          Positioned(
            left: _rocketX * screenWidth,
            top: _rocketY * screenHeight,
            child: Image.asset(
              'assets/rocket_new.png',
              width: screenWidth * 0.1,
              height: screenWidth * 0.1,
            ),
          ),

          // Sun in the center
          Center(
            child: Image.asset(
              'assets/Sun_Edited (1).png',
              width: screenWidth * 0.55,
              height: screenWidth * 0.55,
            ),
          ),

          // Space Words
          Positioned(
            top: screenHeight * 0.01,
            left: 0,
            child: SizedBox(
              height: screenHeight * 0.2,
              width: screenWidth,
              child: Image.asset(
                'assets/Space Text (2).png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.logout),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: screenWidth * 0.12, // Relative to screen width
              onPressed: () async {
                // Wait for logout to complete before navigating
                await logout();
                if (context.mounted) {
                  // Check if widget is still mounted
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AuthGate()),
                    (route) => false,
                  );
                }
              },
            ),
          ),
          // Info button
          //*logout button
          /*
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
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AuthGate()),
                  (route) => false,
                );
              },
            ),
          ),
*/
          //*Info button
          Positioned(
            top: 50,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.info),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: screenWidth * 0.12,
              onPressed: () {
                iHomePopup(context);
              },
            ),
          ),
          /*Positioned(
            top: 100,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.lightbulb),
              color: Colors.yellow[200],
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: screenWidth * 0.12, // Relative to screen width
              onPressed: () {
                logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AboutMePage()),
                  (route) => false,
                );
              },
            ),
          ),*/
          // Planets
          Positioned(
            top: screenHeight * 0.19,
            left: screenWidth * 0.07,
            child: Image.asset(
              'assets/Saturn.png',
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
            ),
          ),
          Positioned(
            top: screenHeight * 0.58,
            left: screenWidth * 0.4,
            child: Image.asset(
              'assets/Earth.png',
              width: screenWidth * 0.23,
              height: screenWidth * 0.23,
            ),
          ),
          Positioned(
            top: screenHeight * 0.52,
            left: screenWidth * 0.1,
            child: Image.asset(
              'assets/Mars.png',
              width: screenWidth * 0.27,
              height: screenWidth * 0.27,
            ),
          ),
          Positioned(
            top: screenHeight * 0.27,
            right: screenWidth * 0.05,
            child: InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatPage(), // Replace with your desired page
                  ),
                  (route) => false,
                );
              },
              child: Image.asset(
                'assets/Neptune AI (1).png',
                width: screenWidth * 0.25,
                height: screenWidth * 0.25,
              ),
            ),
            /*
            top: screenHeight * 0.27,
            right: screenWidth * 0.05,
            child: Image.asset(
              'assets/Neptune AI (1).png',
              width: screenWidth * 0.25,
              height: screenWidth * 0.25,
              
            ),*/
          ),
          Positioned(
            top: screenHeight * 0.4,
            right: screenWidth * 0.0,
            child: Image.asset(
              'assets/Mercury (1).png',
              width: screenWidth * 0.25,
              height: screenWidth * 0.25,
            ),
          ),
          Positioned(
            top: screenHeight * 0.5,
            right: screenWidth * 0.1,
            child: Image.asset(
              'assets/Venus_HotTopic (1).png',
              width: screenWidth * 0.3,
              height: screenWidth * 0.35,
            ),
          ),

          // Interactive Uranus
          Positioned(
            top: screenHeight * 0.2,
            right: screenWidth * 0.27,
            child: InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WordSearchGame(), // Replace with your desired page
                  ),
                  (route) => false,
                );
              },
              child: Image.asset(
                'assets/Uranian Search.png',
                width: screenWidth * 0.25,
                height: screenWidth * 0.25,
              ),
            ),
          ),

          Positioned(
            top: 100,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: screenWidth * 0.12,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
          ),
          // Interactive Jupiter
          Positioned(
            top: screenHeight * 0.37,
            left: screenWidth * 0.00,
            child: InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DragAndDropGame(), // Replace with your desired page
                  ),
                  (route) => false,
                );
              },
              child: Image.asset(
                'assets/Jupiter.png',
                width: screenWidth * 0.25,
                height: screenWidth * 0.25,
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * .1,
            right: screenWidth * .15,
            child: Container(
              height: screenHeight * .05,
              width: screenWidth * .7,
              decoration: BoxDecoration(
                color: Colors.black45, // Background color
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: Center(
                child: Text(
                  "Total Points: $total_points",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: screenHeight * .05,
            right: screenWidth * .10,
            child: Container(
              height: screenHeight * .05,
              width: screenWidth * .8,
              decoration: BoxDecoration(
                color: Colors.black45, // Background color
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: Center(
                child: Text(
                  "Available Points: $points",
                  style: TextStyle(
                    color: Colors.orange[200],
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
