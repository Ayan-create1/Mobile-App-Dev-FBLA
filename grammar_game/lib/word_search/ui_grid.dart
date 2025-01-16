import 'package:flutter/material.dart';
import 'word_grid.dart';

//!Made using generative AI tools
class WordSearchGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WordGridState();
  }
}

class _WordGridState extends State<WordSearchGame> {
  @override
  Widget build(BuildContext context) {
    //*Scaffold will define new page in application
    return Scaffold(
      //*Will show text login at the top
      appBar: AppBar(
        //*Will show title of screen and center that title
        centerTitle: true,
        title: Text(
          "SEARCH TENSE",
          style: TextStyle(
            color: Colors.yellow,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      //*Body will define how the scaffold looks
      body: _buildUI(),
    );
  }
}

Widget _buildUI() {
  List<List<String>> grid = test();
  List<Widget> rows = [];
  for (var row in grid) {
    List<Widget> cells = [];
    for (var cell in row) {
      cells.add(
        Container(
          alignment: Alignment.center,
          width: 27,
          height: 27,
          margin: EdgeInsets.all(3),
          /*decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(4),
          ),*/
          child: Text(
            cell,
            style: TextStyle(
              color: Colors.amber,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    rows.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: cells,
      ),
    );
  }
  return Scaffold(
    backgroundColor: Colors.black,
    body: Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: rows,
      ),
    ),
  );
}
