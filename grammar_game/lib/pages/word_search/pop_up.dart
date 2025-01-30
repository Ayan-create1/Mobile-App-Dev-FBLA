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
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Uranian Search Instructions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Follow these steps to get started:",
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
              )
            ],
          ),
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
              child: SizedBox(
                width: 170,
                height: 110,
                child: Center(
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            },
                            child: Text("Home"),
                          ),
                        ),
                        Container(
                          height: 10,
                          color: Colors.blue[100],
                        ),
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Replay"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]);
    },
  );
}
