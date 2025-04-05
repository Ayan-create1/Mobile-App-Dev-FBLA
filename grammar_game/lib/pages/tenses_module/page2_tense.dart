// ignore_for_file: deprecated_member_use

import 'page3_tense.dart';
import 'package:flutter/material.dart';
import 'package:grammar_game/pages/home_page/home_page.dart';
import '../word_search/ui_grid.dart';
import 'page1_tense.dart';

class Tense2Page extends StatefulWidget {
  @override
  _Tense2PageState createState() => _Tense2PageState();
}

class _Tense2PageState extends State<Tense2Page> {
  final Map<String, String> MapKey = {
    "if": "conditional",
    "currently": "present",
    "previously": "past",
    "predicts": "future",
    "yesterday": "past",
    "might": "conditional",
    "tomorrow": "future",
    "always": "present"
  };

  final List<String> tiles = [
    "if",
    "currently",
    "previously",
    "predicts",
    "yesterday",
    "might",
    "tomorrow",
    "always"
  ];

  final List<String> boxes = ["present", "past", "future", "conditional"];
  Map<String, String> placement = {};
  Map<String, Color> tileColors = {};

  @override
  void initState() {
    super.initState();
    for (var tile in tiles) {
      tileColors[tile] = Colors.lightBlue;
    }
  }

  void resetState() {
    setState(() {
      placement = {}; // Clear all placements
      tileColors = {
        for (var tile in tiles) tile: Colors.lightBlue, // Reset tile colors
      };
    });
  }

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
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: 50.0,
              onPressed: () {
                resetState();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Tense1Page(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.grid_view),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: 50.0,
              onPressed: () {
                resetState();
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
                resetState();
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
                resetState();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Tense3Page(), // Your HomePage widget
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
              _instructionBox(),
              _emptyContainer(20.0),
              _tenseInfo1(),
              _emptyContainer(5),
              _tenseInfo2(),
              _emptyContainer(20.0),
              Container(
                width: MediaQuery.of(context).size.width * .95,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple[900], // Background color
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                child: Center(
                  child: _dragDrop(),
                ),
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

  Widget _iPage() {
    return Container(
      width: MediaQuery.of(context).size.width * .95,
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
                text: "In Bottom Naviagation Bar\nPrevious Page: ",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              WidgetSpan(
                child: Icon(Icons.arrow_back, color: Colors.black),
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
              TextSpan(
                text: "\nNext Page: ",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              WidgetSpan(
                child: Icon(Icons.arrow_forward, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dragDrop() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Trigger Words Activity",
          style: TextStyle(
            fontSize: 25,
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        _emptyContainer(15.0),
        Text(
          "Each of the words in the word bank are common triggers for certain tenses. Drag each trigger word into its respective tense box",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
        _emptyContainer(20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildDropBox(boxes[index]), // Drop box widget
                SizedBox(height: 8), // Space between box and caption
                Text(
                  boxes[index], // Caption under the box
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // You can customize the color
                  ),
                ),
              ],
            );
          }),
        ),
        _emptyContainer(20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildDropBox(boxes[index + 2]), // Drop box widget
                SizedBox(height: 8), // Space between box and caption
                Text(
                  boxes[index + 2], // Caption under the box
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // You can customize the color
                  ),
                ),
              ],
            );
          }),
        ),
        SizedBox(height: 40),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: tiles.map((tile) => buildTile(tile)).toList(),
        ),
        SizedBox(height: 30),
        ElevatedButton(onPressed: checkAnswers, child: Text('Check')),
        _emptyContainer(20.0),
        Text(
          "Please go to a different page using the bottom navigation bar and then come back to this page to try this activity again",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
        _emptyContainer(20.0)
      ],
    );
  }

  Widget buildDropBox(String boxLabel) {
    List<String> tilesInBox = placement.entries
        .where((entry) => entry.value == boxLabel)
        .map((entry) => entry.key)
        .toList();

    return DragTarget<String>(
      onAccept: (tileLabel) {
        setState(() {
          placement[tileLabel] = boxLabel;
          tileColors[tileLabel] = Colors.lightBlue;
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.all(8),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: tilesInBox.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                  children: tilesInBox
                      .map((tile) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: tileWidget(tile),
                          ))
                      .toList(),
                ))
              : Text(
                  boxLabel,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
        );
      },
    );
  }

  Widget buildTile(String tileLabel) {
    if (placement.containsKey(tileLabel)) {
      return SizedBox(width: 80, height: 50); // Empty space
    }
    return Draggable<String>(
      data: tileLabel,
      feedback: Material(child: tileWidget(tileLabel)),
      childWhenDragging: Container(width: 80, height: 50),
      child: tileWidget(tileLabel),
    );
  }

  Widget tileWidget(String label) {
    return Container(
      width: 80,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tileColors[label] ?? Colors.blue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }

  void checkAnswers() {
    setState(() {
      for (var entry in placement.entries) {
        if (MapKey[entry.key] == entry.value) {
          tileColors[entry.key] = Colors.green;
        } else {
          tileColors[entry.key] = Colors.red;
        }
      }
    });
  }

  Widget _emptyContainer(double i) {
    return Container(
      height: i,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
    );
  }

  Widget _emptyContainerW(double i) {
    return Container(
      width: i,
      color: Colors.transparent,
    );
  }

  Widget _title() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.center,
      child: Text(
        "Overview of Tenses",
        style: TextStyle(
          fontSize: 25,
          color: Colors.yellow,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _instructionBox() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.deepPurple[900], // Background color
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: Text(
        "Read about some of the conjugation types below and then do the interactive drag and drop to see the various tense triggers",
        style: TextStyle(
          fontSize: 15,
          color: Colors.yellow[300],
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _tenseInfo1() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.32,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepPurple[600], // Background color
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            child: Column(
              children: [
                Text(
                  "Present Tense",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                _emptyContainer(10.0),
                Text(
                  "Used to convey actions that are occurring in the moment or have been going on and have not stopped.\n\nExample: I smile every morning",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          _emptyContainerW(5.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.32,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepPurple[600], // Background color
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            child: Column(
              children: [
                Text(
                  "Past Tense",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                _emptyContainer(10.0),
                Text(
                  "Conveys actions that have happened in the past or actions that used to occur but have stopped continuing.\n\nExample: I walked on my birthday",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tenseInfo2() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.4,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepPurple[400], // Background color
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            child: Column(
              children: [
                Text(
                  "Future \nTense",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                _emptyContainer(10.0),
                Text(
                  "Used to convey actions that will occur but have not happened yet. This tense is often associated with predictions that are usually affirmative\n\nExample: I will finish my homework",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          _emptyContainerW(5.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.4,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepPurple[400], // Background color
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            child: Column(
              children: [
                Text(
                  "Conditional Tense",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                _emptyContainer(10.0),
                Text(
                  "Conveys actions that have a possibility of occuring. Uses words such as could or if to convey these possibilities.\n\nExample: I might scream",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
