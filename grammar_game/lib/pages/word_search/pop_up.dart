// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../home_page/home_page.dart';

//! Implement navigation to home page

void iWordSPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Uranian Search",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Follow the steps below",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildInstructionStep(
                      "Find the correct verb tense of the infinitive in the word bank"),
                  Text("Ex: to run - past => ran"),
                  _buildInstructionStep(
                      "Once that word is found and is in the correct tense, highlight that word by running your finger across it"),
                  _buildInstructionStep(
                      "If that word is in the correct tense once the dragging has stopped, the words highlight should turn green"),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.close_sharp,
                          color: Colors.red, size: 20), // Bullet point icon
                      SizedBox(width: 8), // Space between icon and text
                      Expanded(
                        child: Text(
                          "You cannot highlight diagonally. Only horizontal and vertical highlighting is accepted",
                          style: TextStyle(fontSize: 14),
                        ), // Instruction text
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Got it!"),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -10, // Adjust to position outside the dialog
              right: -10, // Adjust position
              child: CircleAvatar(
                backgroundColor: Colors.lightBlue[100],
                radius: 40,
                backgroundImage: AssetImage(
                  'assets/astronaut.webp',
                ), // Replace with your image
              ),
            ),
            Positioned(
              bottom: -10, // Adjust to position outside the dialog
              left: -10, // Adjust position
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 40,
                backgroundImage: AssetImage(
                  'assets/uranusPop.png',
                ), // Replace with your image
              ),
            ),
          ],
        ),
      );
    },
  );
}

void iDragDPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Gravity Drop",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Follow the steps below:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildInstructionStep(
                      "Read the sentence and choose the appropriate punctuation"),
                  _buildInstructionStep(
                      "Drag the selected punctuation into the answer box and hit check answer to check if your answer if right"),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Got it!"),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: -10, // Adjust to position outside the dialog
              right: -10, // Adjust position
              child: CircleAvatar(
                backgroundColor: Colors.deepOrange[300],
                radius: 40,
                backgroundImage: AssetImage(
                  'assets/astronaut.webp',
                ), // Replace with your image
              ),
            ),
            Positioned(
              bottom: -10, // Adjust to position outside the dialog
              left: -10, // Adjust position
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 40,
                backgroundImage: AssetImage(
                  'assets/jupiterPop.png',
                ), // Replace with your image
              ),
            ),
          ],
        ),
      );
    },
  );
}

void iHomePopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Space Words",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Explore our universe of words",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildInstructionStep("Uranian Search"),
                  Text(
                      "Explore the icy depths of Uranus by playing the classic Uranian version of Word Search. (10-20 points per correct question)"),
                  _buildInstructionStep("Gravity Drop"),
                  Text(
                      "With constant storms and crazy gravitaty, try playing the classic Jupiterien version of Drag and Drop. (150-200 points per each completion)"),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Let's Start Exploring!"),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100, // Adjust to position outside the dialog
              right: -40, // Adjust position
              child: Image.asset(
                'assets/Uranian Search.png', // Replace with your image asset
                width: 60, // Set image width
                height: 60, // Set image height
                fit: BoxFit.contain, // Ensures the image is fully visible
              ),
            ),
            Positioned(
              top: 200, // Adjust to position outside the dialog
              right: -40, // Adjust position
              child: Image.asset(
                'assets/Jupiter.png', // Replace with your image asset
                width: 60, // Set image width
                height: 60, // Set image height
                fit: BoxFit.contain, // Ensures the image is fully visible
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildInstructionStep(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check, color: Colors.green, size: 20), // Bullet point icon
        SizedBox(width: 8), // Space between icon and text
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 14)), // Instruction text
        ),
      ],
    ),
  );
}

void showPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(20),
        backgroundColor: Colors.blue[100],
        title: Center(
          child: Text("Good Job!"),
        ),
        //content: Text("This is the popup content"),
        actions: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(BorderSide(
                          color: Colors.black,
                          width: 2)), // Black border around the button
                      minimumSize: MaterialStateProperty.all(Size(
                          double.infinity,
                          20)), // Button height (adjust as needed)
                      backgroundColor: MaterialStateProperty.all(
                          Colors.white), // Background color of button
                    ),
                    child: Text("Home"),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(BorderSide(
                          color: Colors.black,
                          width: 2)), // Black border around the button
                      minimumSize: MaterialStateProperty.all(Size(
                          double.infinity,
                          20)), // Button height (adjust as needed)
                      backgroundColor: MaterialStateProperty.all(
                          Colors.white), // Background color of button
                    ),
                    child: Text("Replay"),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
