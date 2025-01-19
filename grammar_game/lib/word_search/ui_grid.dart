import 'package:flutter/material.dart';
import 'word_grid.dart';
//import 'dart:async';

Map<String, bool> highlightStatus = {};
Map<String, bool> correctWords = {};
List<List<String>> myDict = getWords();
List<String> words = myDict[0];
List<String> hints = myDict[1];
List<List<String>> grid = test(words);
String? currenthighlightStatus;
String? currentcorrectWords;
List<String> highlightedWords = [];
int oRow = 0;
int oCol = 0;

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
  final double cellSize = 30.0;
  final int rowL = 9;
  final int colL = 9;

  int? previousRow;
  int? previousColumn;
  @override
  Widget build(BuildContext context) {
    //*Scaffold will define new page in application
    //*Returns the entire project page
    return Scaffold(
      backgroundColor: Colors.black,
      //*Return the appbar with title center, title with special text, and background properties
      appBar: AppBar(
        //*Will show title of screen and center that title
        centerTitle: true,
        title: Text(
          "SEARCH TENSE",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      //*Body will define how the scaffold looks
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onPanStart: _handlePanStart,
              onPanUpdate: _handlePanUpdate,
              onPanEnd: (_) => _resolveHighlights(),
              child: _buildUI(),
            ),
            _buildBank(),
          ],
        ),
      ),
    );
  }

  Widget _buildBank() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: hints
                    .sublist(0, 5)
                    .map((item) => Text(
                          item,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                    .toList(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: hints
                    .sublist(5, 10)
                    .map(
                      (item) => Text(
                        item,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildUI() {
    List<Widget> rows = [];
    for (int i = 0; i < grid.length; i++) {
      List<Widget> cells = [];
      for (int j = 0; j < grid[i].length; j++) {
        String letterKey = "$i-$j";
        cells.add(
          Container(
            alignment: Alignment.center,
            width: 34,
            height: 34,
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: highlightStatus[letterKey] == true
                  ? Colors.purple[300]
                  : correctWords[letterKey] == true
                      ? Colors.green
                      : Colors.transparent,
              /*
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                  */
            ),
            child: Text(
              grid[i][j],
              style: TextStyle(
                color: Colors.white,
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

    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: rows,
      ),
    );
  }

  void _handlePanStart(DragStartDetails details) {
    _handleDrag(details.globalPosition);
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    _handleDrag(details.globalPosition);
  }

  void _handleDrag(Offset globalPosition) {
    final RenderBox gridBox = context.findRenderObject() as RenderBox;
    final Offset localPosition = gridBox.globalToLocal(globalPosition);

    int row = ((localPosition.dy / 36).floor()) - 3;
    int column = ((localPosition.dx / 36).floor());

    if (row >= 0 && column >= 0 && row <= rowL && column <= colL) {
      String cellKey = "$row-$column";
      if (previousRow == null && previousColumn == null) {
        previousRow = row;
        previousColumn = column;
      }

      if (previousRow != null && previousColumn != null) {
        if (row != previousRow && column != previousColumn) {
          return;
        }
      }
      setState(() {
        highlightStatus[cellKey] = true;
      });

      if (oRow != row || oCol != column) {
        highlightedWords.add(grid[row][column]);
        oRow = row;
        oCol = column;
      }
      previousRow = row;
      previousColumn = column;
    }
  }

  void _resolveHighlights() {
    bool status = false;

    String checkWord = highlightedWords.join('');
    for (int i = 0; i < words.length; i++) {
      if (words[i] == checkWord) {
        status = true;
        if (status == true) {
          correctWords.addAll(highlightStatus);
        }
        break;
      }
    }
    print("$words");
    print("$highlightedWords-$checkWord-$status");

    setState(() {
      highlightStatus.clear();
    });
    highlightedWords.clear();
    previousRow = null;
    previousColumn = null;
  }
}
