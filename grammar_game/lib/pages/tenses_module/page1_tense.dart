// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:grammar_game/pages/home_page/home_page.dart';
import '../word_search/ui_grid.dart';
import 'page2_tense.dart';

//!Get rid of this once this page is finished

/*
void main() {
  runApp(MaterialApp(
    home: Tense1Page(), // Wrap in MaterialApp
  ));
}
*/

class Tense1Page extends StatefulWidget {
  @override
  _Tense1PageState createState() => _Tense1PageState();
}

class _Tense1PageState extends State<Tense1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        shadowColor: Colors.black,
        centerTitle: true,
        title: Text(
          "TENSES MODULE",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue[300], // You can customize the color here
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the button, adjust if needed
          children: [
            IconButton(
              icon: Icon(Icons.grid_view),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: 50.0,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WordSearchGame(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: 50.0,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(), // Your HomePage widget
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: 50.0,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Tense2Page(), // Your HomePage widget
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _emptyContainer(30.0),
              _title(),
              _emptyContainer(20.0),
              _infoBox(),
              _emptyContainer(20.0),
              Container(
                width: MediaQuery.of(context).size.width * .85,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[900], // Background color
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                child: TapToRevealTexts(),
              ),
              _emptyContainer(20.0),
              _iPage(),
              _emptyContainer(70.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.center,
      child: Text(
        "Intro to Verb Conjugation",
        style: TextStyle(
          fontSize: 25,
          color: Colors.yellow,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _iPage() {
    return Container(
      width: MediaQuery.of(context).size.width * .85,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red[100], // Background color
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "In Bottom Naviagation Bar\nNext Page: ",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              WidgetSpan(
                child: Icon(Icons.arrow_forward, color: Colors.black),
              ),
              TextSpan(
                text: "\nUranian Search: ",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              WidgetSpan(
                child: Icon(Icons.grid_view, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoBox() {
    return Container(
      width: MediaQuery.of(context).size.width * .85,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.lightBlue[900], // Background color
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: Text(
        "Verb conjugation is a crucial component of any language. It allows us to communicate times, specify who is doing certain actions, and identify different tones and completed actions.",
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _emptyContainer(double i) {
    return Container(
      height: i,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
    );
  }
}

//! Made using AI. Tap to reveal each tense
class TapToRevealTexts extends StatefulWidget {
  @override
  _TapToRevealTextsState createState() => _TapToRevealTextsState();
}

class _TapToRevealTextsState extends State<TapToRevealTexts> {
  bool _isText1Revealed = false;
  bool _isText2Revealed = false;
  bool _isText3Revealed = false;
  bool _isText4Revealed = false;

  void _toggleText1() {
    setState(() {
      _isText1Revealed = !_isText1Revealed;
    });
  }

  void _toggleText2() {
    setState(() {
      _isText2Revealed = !_isText2Revealed;
    });
  }

  void _toggleText3() {
    setState(() {
      _isText3Revealed = !_isText3Revealed;
    });
  }

  void _toggleText4() {
    setState(() {
      _isText4Revealed = !_isText4Revealed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "Infinitive: Crushed",
              style: TextStyle(
                fontSize: 22,
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          _emptyContainer(15.0),
          GestureDetector(
            onTap: _toggleText1,
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.lightBlue[300], // Background color
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: Column(
                children: [
                  Text(
                    _isText1Revealed ? "Present Tense" : "Present Tense",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_isText1Revealed)
                    Text(
                      "crush",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.yellow[400],
                      ),
                    ),
                ],
              ),
            ),
          ),
          _emptyContainer(10.0),
          GestureDetector(
            onTap: _toggleText2,
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.lightBlue[300], // Background color
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: Column(
                children: [
                  Text(
                    _isText2Revealed ? "Past Tense" : "Past Tense",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_isText2Revealed)
                    Text(
                      "crushed",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.yellow[400],
                      ),
                    ),
                ],
              ),
            ),
          ),
          _emptyContainer(10.0),
          GestureDetector(
            onTap: _toggleText3,
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.lightBlue[300], // Background color
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: Column(
                children: [
                  Text(
                    _isText3Revealed ? "Future Tense" : "Future Tense",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_isText3Revealed)
                    Text(
                      "will crush",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.yellow[400],
                      ),
                    ),
                ],
              ),
            ),
          ),
          _emptyContainer(10.0),
          GestureDetector(
            onTap: _toggleText4,
            child: Container(
              width: MediaQuery.of(context).size.width * .5,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.lightBlue[300], // Background color
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: Column(
                children: [
                  Text(
                    _isText4Revealed
                        ? "Conditional Tense"
                        : "Conditional Tense",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_isText4Revealed)
                    Text(
                      "would crush",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.yellow[400],
                      ),
                    ),
                ],
              ),
            ),
          ),
          _emptyContainer(10.0),
          Text(
            "Click on each of the boxes to see the infinitive verb in all of its conjugated forms",
            style: TextStyle(
              fontSize: 15,
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _emptyContainer(double i) {
    return Container(
      height: i,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
    );
  }
}
