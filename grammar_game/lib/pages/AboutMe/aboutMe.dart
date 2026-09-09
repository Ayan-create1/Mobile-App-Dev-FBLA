import 'package:flutter/material.dart';
import 'package:grammar_game/pages/Login_page/auth_gate.dart';

// Entry point of the Flutter app
/*void main() {
  runApp(AboutMeApp());
}
*/

// Top-level widget for the app
class AboutMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      home: AboutMePage(), // Runs the AboutMePage widget
    );
  }
}

// About Me Page
class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ABOUT US',
          style: TextStyle(
            color: Colors.yellow[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => AuthGate()),
              (route) => false,
            );
          },
        ),
      ),
      /*
      appBar: AppBar(
        title: Text(
          'ABOUT US',
          style: TextStyle(
            color: Colors.yellow[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple[900], // Dark space-themed AppBar
      ),
      */
      body: Container(
        width: double.infinity, // Full screen width
        height: double.infinity, // Full screen height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.deepPurple, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: screenWidth, height: 30),
              // Section: Our Task
              buildSection(
                title: 'Our Task',
                content:
                    'Design a mobile application that gamifies learning for subjects like math, science, history, or language arts, offering interactive quizzes, puzzles, and progress tracking.',
                screenWidth: screenWidth,
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Section: Our App
              buildSection(
                title: 'Our App',
                content:
                    'A game where users can come to learn and practice various grammar concepts.',
                screenWidth: screenWidth,
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Section: Correlation with the Prompt
              buildBulletSection(
                title: 'How Our App Addresses the Prompt',
                bullets: [
                  'Gamifies learning through interactive game modes and challenges.',
                  'Teaches grammar concepts through various built-in modules that contain their own interactice games.',
                  'Includes a fun and engaging theme.',
                ],
                screenWidth: screenWidth,
              ),
              const SizedBox(height: 16.0), // Spacing between sections
              buildBulletSection(
                title: 'The Method',
                bullets: [
                  'The modules function as a small quiz to test the knowledge of the user',
                  'The puzzles like wordsearch and drag and drop are meant to enhance our users engagement',
                  'Rather than directly tracking progress, we use a points system to further motivate our users',
                ],
                screenWidth: screenWidth,
              ),
              const SizedBox(height: 16.0),
              // Section: More About the Theme
              buildSection(
                title: 'More About Our App’s Theme',
                content:
                    'Space is a captivating theme that resonates with people of all ages. Within our app, this theme is thoughtfully woven into the graphics and design elements, fostering an immersive experience that inspires curiosity and enhances user engagement.',
                screenWidth: screenWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Widget for Simple Sections
  Widget buildSection({
    required String title,
    required String content,
    required double screenWidth,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0), // Spacing between title and content
          Text(
            content,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Widget for Bulleted List Sections
  Widget buildBulletSection({
    required String title,
    required List<String> bullets,
    required double screenWidth,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0), // Spacing between title and content
          for (String bullet in bullets)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Text(
                    bullet,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
