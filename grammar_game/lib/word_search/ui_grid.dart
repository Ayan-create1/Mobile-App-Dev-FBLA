import 'package:flutter/material.dart';
import 'word_grid.dart';

Map<String, bool> highlightStatus = {};
List<List<String>> grid = test();

//!Made using generative AI tools
//*This class will display the wordsearch page
class WordSearchGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //*Will display the state of the grid
    return _WordGridState();
  }
}

class _WordGridState extends State<WordSearchGame> {
  @override
  Widget build(BuildContext context) {
    //*Scaffold will define new page in application
    //*Returns the entire project page
    return Scaffold(
      //*Return the appbar with title center, title with special text, and background properties
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

  Widget _buildUI() {
    List<Widget> rows = [];
    for (int i = 0; i < grid.length; i++) {
      List<Widget> cells = [];
      for (int j = 0; j < grid[i].length; j++) {
        String letterKey = "$i-$j";

        cells.add(
          GestureDetector(
            onPanStart: (details) => _highlightCell(i, j),
            onPanUpdate: (details) => _highlightCell(i, j),
            onPanEnd: (details) => _uncolorCell(i, j),
            child: Container(
              alignment: Alignment.center,
              width: 27,
              height: 27,
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: highlightStatus[letterKey] == true
                    ? Colors.blue[200]
                    : Colors.transparent,
                /*
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                  */
              ),
              child: Text(
                grid[i][j],
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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

  void _highlightCell(int row, int column) {
    String letterKey = "$row-$column";

    setState(() {
      highlightStatus[letterKey] = true;
    });
  }

  void _uncolorCell(int row, int column) {
    String letterKey = "$row-$column";
    setState(() {
      highlightStatus[letterKey] = false;
    });
  }
}
