import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:grammar_game/pages/Login_page/auth_gate.dart';
import 'package:grammar_game/pages/Login_page/pages/signin_page.dart';


// Entry point of the Flutter app
void main() {
  runApp(AboutMeApp());
}
=======

// Entry point of the Flutter app
/*void main() {
  runApp(AboutMeApp());
}
*/
>>>>>>> eb8b523b80ac3745727048aae8954883b0bf921c

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
<<<<<<< HEAD
      appBar: AppBar(    
        title: Text('About Us'),
        backgroundColor: Colors.white12, // Dark space-themed AppBar
        leading: IconButton(
  icon: Icon(Icons.arrow_back), // Back icon
  onPressed: () {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => AuthGate()),
      (route) => false, // Clears all previous routes
    );
  },
),
=======
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.black87, // Dark space-themed AppBar
>>>>>>> eb8b523b80ac3745727048aae8954883b0bf921c
      ),
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
              // Section: Our Task
              buildSection(
                title: 'Our Task',
<<<<<<< HEAD
                content: 'Design a mobile application that gamifies learning for subjects like math, science, history, or language arts, offering interactive quizzes, puzzles, and progress tracking.',
=======
                content:
                    'Design a mobile application that gamifies learning for subjects like math, science, history, or language arts, offering interactive quizzes, puzzles, and progress tracking.',
>>>>>>> eb8b523b80ac3745727048aae8954883b0bf921c
                screenWidth: screenWidth,
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Section: Our App
              buildSection(
                title: 'Our App',
<<<<<<< HEAD
                content: 'A game where users can come to learn and practice various grammar concepts.',
=======
                content:
                    'A game where users can come to learn and practice various grammar concepts.',
>>>>>>> eb8b523b80ac3745727048aae8954883b0bf921c
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

              // Section: More About the Theme
              buildSection(
                title: 'More About Our App’s Theme',
<<<<<<< HEAD
                content: 'Space is a captivating theme that resonates with people of all ages. Within our app, this theme is thoughtfully woven into the graphics and design elements, fostering an immersive experience that inspires curiosity and enhances user engagement.',
=======
                content:
                    'Space is a captivating theme that resonates with people of all ages. Within our app, this theme is thoughtfully woven into the graphics and design elements, fostering an immersive experience that inspires curiosity and enhances user engagement.',
>>>>>>> eb8b523b80ac3745727048aae8954883b0bf921c
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
<<<<<<< HEAD
}
=======
}
>>>>>>> eb8b523b80ac3745727048aae8954883b0bf921c
