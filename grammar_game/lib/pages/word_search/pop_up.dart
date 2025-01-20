import 'package:flutter/material.dart';
import '../home_page/home_page.dart';

//! Implement navigation to home page

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
