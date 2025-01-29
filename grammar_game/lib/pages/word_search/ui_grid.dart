import 'package:flutter/material.dart';
import 'package:grammar_game/pages/home_page/home_page.dart';
import 'word_grid.dart';
import 'pop_up.dart';
import 'uranus.dart';

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
bool isHorizontal = false;
Offset previousLocalPosition = Offset.zero;
Map<String, bool> wordStatus = {};
List<String> counter = [];

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

  //Will allow previous row and colum to be null
  int? previousRow;
  int? previousColumn;
  @override
  Widget build(BuildContext context) {
    //Scaffold will define new page in application
    //Returns the entire project page
    return Scaffold(
      //backgroundColor: Colors.black,
      //Return the appbar with title center, title with special text, and background properties
      appBar: AppBar(
        shadowColor: Colors.blueAccent,
        //Will show title of screen and center that title
        centerTitle: true,
        title: Text(
          "URANIAN SEARCH",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[900],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue[300], // You can customize the color here
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the button, adjust if needed
          children: [
            IconButton(
              icon: Icon(Icons.info),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: 50.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(), // Your HomePage widget
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(), // Your HomePage widget
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.share),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: 50.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(), // Your HomePage widget
                  ),
                );
              },
            ),
          ],
        ),
      ),
      //Body will define how the scaffold looks
      body: Center(
        //Will make a column widget where buildUI has gesture detectors then wordbank under
        child: Stack(
          children: [
            Positioned.fill(
              child: AuroraEffect(),
            ),
            Column(
              children: [
                _emptyContainter(),
                GestureDetector(
                  onPanStart: _handlePanStart,
                  onPanUpdate: _handlePanUpdate,
                  onPanEnd: (_) => _resolveHighlights(),
                  child: _buildUI(),
                ),
                _emptyContainter(),
                _buildBank(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyContainter() {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
    );
  }

  //*Will build the word bank
  Widget _buildBank() {
    return Column(
      //Will try to start this column at the end
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          //There will be a row widget inside this containter
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //The column will be inside the row
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //Is going to get value 0,5 from hints and put them in the column
                children: hints
                    .sublist(0, 5)
                    .map((item) => Text(
                          item,
                          style: TextStyle(
                            //if wordStatus of the word is true, color will be green else white
                            //!Problem could be not adding anything to show item is true
                            color: wordStatus[item] == true
                                ? Colors.green
                                : Colors.white,
                            fontSize: 18,
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
                          color: wordStatus[item] == true
                              ? Colors.green
                              : Colors.white,
                          fontSize: 18,
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
    //Will contain all of the row widgets
    List<Widget> rows = [];
    //Will add each row individually to cells
    for (int i = 0; i < grid.length; i++) {
      List<Widget> cells = [];
      for (int j = 0; j < grid[i].length; j++) {
        //! Important
        //We are adding a letterKey to idenitify each of the containers
        String letterKey = "$i-$j";
        cells.add(
          Container(
            alignment: Alignment.center,
            width: 34,
            height: 34,
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              //If containter is touched, make it purple, else if correctly highlighted, make green, else keep trans
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

    //Will return a container of row widgets
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: rows,
      ),
    );
  }

  //Wbhen PanStarts, will go to handle drag
  void _handlePanStart(DragStartDetails details) {
    _handleDrag(details.globalPosition);
  }

  //When PanUpdates, will go to handle drag
  void _handlePanUpdate(DragUpdateDetails details) {
    _handleDrag(details.globalPosition);
  }

  //Will handle all drag related motions
  void _handleDrag(Offset globalPosition) {
    //Will make the grid a local position on the phone. That will be converted to a local position for Pan features
    final RenderBox gridBox = context.findRenderObject() as RenderBox;
    final Offset localPosition = gridBox.globalToLocal(globalPosition);

    //Will get the position of the x and y for the column and row
    int row = ((localPosition.dy / 36).floor()) - 4;
    int column = ((localPosition.dx / 36).floor()) - 1;

    //checks that row and column are within bounds
    if (row >= 0 && column >= 0 && row <= rowL && column <= colL) {
      //Makes this cellKey showing current row and column
      //! Important for text change color
      String cellKey = "$row-$column";

      //*Attempts to only allow certain swipe direction
      /*
      if (previousRow == null && previousColumn == null) {
        previousRow = row;
        previousColumn = column;
      }

      if (previousRow != null && previousColumn != null) {
        double deltaX = localPosition.dx - previousLocalPosition.dx;
        double deltaY = localPosition.dy - previousLocalPosition.dy;

        if (deltaX.abs() > deltaY.abs()) {
          isHorizontal = true;
        }
        // If the movement is primarily vertical
        else if (deltaY.abs() > deltaX.abs()) {
          isHorizontal = false;
        }

        if (isHorizontal && row != previousRow) {
          return;
        }
        if (!isHorizontal && column != previousColumn) {
          return;
        }
      }
      */

      //if our row and column are valid, our cellKey status will be set to true
      setState(() {
        highlightStatus[cellKey] = true;
      });

      //Prevents double highlighting
      if (oRow != row || oCol != column) {
        highlightedWords.add(grid[row][column]);
        oRow = row;
        oCol = column;
      }
      /*
      previousRow = row;
      previousColumn = column;
      previousLocalPosition = localPosition;
      */
    }
  }

  void _resolveHighlights() {
    bool status = false;
    //Will check if final result is matching in word bank
    String checkWord = highlightedWords.join('');
    for (int i = 0; i < words.length; i++) {
      if (words[i] == checkWord) {
        status = true;
        if (status == true) {
          correctWords.addAll(highlightStatus);
          setState(() {
            wordStatus[hints[i]] = true;
          });
          counter.add(checkWord);
        }
        break;
      }
    }

    print("$words");
    print("$highlightedWords-$checkWord-$status");
    print("$wordStatus");
    //Will clear highlightStatus and highlightedWords
    setState(() {
      highlightStatus.clear();
    });
    highlightedWords.clear();

    if (counter.length == 10) {
      _resetWordSearch();
      showPopup(context);
    }

    /*
      previousRow = null;
      previousColumn = null;
    */
  }

  void _resetWordSearch() {
    setState(() {
      wordStatus.clear();
      correctWords.clear();
      highlightStatus.clear();
      highlightedWords.clear();
      counter.clear();

      myDict = getWords();
      words = myDict[0];
      hints = myDict[1];
      grid = test(words);
    });
  }
}
