import 'package:flutter/material.dart';
//import 'package:grammar_game/pages/drag_and_drop/matching.dart';
import 'package:grammar_game/pages/home_page/home_page.dart';
import 'word_grid.dart';
import 'pop_up.dart';
import 'uranus.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';

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
bool popup = true;
final GlobalKey _gridKey = GlobalKey();

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
  final GlobalKey _screenshotKey = GlobalKey();
  //final double cellSize = 30.0;
  final int rowL = 9;
  final int colL = 9;

  //Will allow previous row and colum to be null
  int? previousRow;
  int? previousColumn;
  @override
  Widget build(BuildContext context) {
    if (popup) {
      // Schedule the iWordSPopup method to run after the build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        iWordSPopup(context);
        popup = false;
      });
    }

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
                  iWordSPopup(context);
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
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _captureAndShare(_screenshotKey);
                  });
                },
              ),
            ],
          ),
        ),
        //Body will define how the scaffold looks
        body: ScreenshotArea(
          screenshotKey: _screenshotKey,
          child: Center(
            //Will make a column widget where buildUI has gesture detectors then wordbank under
            child: Stack(
              children: [
                Positioned.fill(
                  child: AuroraEffect(),
                ),
                Column(
                  children: [
                    _emptyContainter(),
                    Align(
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            0.9, // Adjust as needed
                        //height: MediaQuery.of(context).size.height * 0.5, // Adjust as needed
                        alignment: Alignment.center,
                        //margin: EdgeInsets.only(left: 2),
                        child: GestureDetector(
                          onPanStart: _handlePanStart,
                          onPanUpdate: _handlePanUpdate,
                          onPanEnd: (_) => _resolveHighlights(),
                          child: _buildUI(), // Grid widget
                        ),
                      ),
                    ),
                    _emptyContainter(),
                    _buildBank(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _captureAndShare(GlobalKey boundaryKey) async {
    try {
      if (_screenshotKey.currentContext == null) {
        print("Current context is null. The widget might not be built yet.");
        return;
      }

      final RenderRepaintBoundary boundary = _screenshotKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      if (boundary.debugNeedsPaint) {
        await Future.delayed(Duration(milliseconds: 20));
      }

      //Captures the image
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData == null) return;
      final Uint8List pngBytes = byteData.buffer.asUint8List();

      //Saves Image to temporary file
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/screenshot.png').create();
      await file.writeAsBytes(pngBytes);

      //Shares image with shareplus
      await Share.shareXFiles([XFile(file.path)],
          text: 'Help me on this word search!');
    } catch (e) {
      print("Error capturing and sharing screenshot: $e");
    }
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
    final screenWidth = MediaQuery.of(context).size.width;

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
                            fontSize: screenWidth * 0.045,
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
                          fontSize: screenWidth * 0.045,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
            width: screenWidth * 0.08,
            height: screenHeight * 0.04,
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
                fontSize: screenWidth * 0.05,
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
    return SizedBox(
      //padding: const EdgeInsets.all(0),
      key: _gridKey,
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
    // Ensure the widget context is ready to find the RenderBox
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get the RenderBox for the grid area
      final RenderBox gridBox =
          _gridKey.currentContext?.findRenderObject() as RenderBox;

      // Convert the global position to local position relative to the grid
      final Offset localPosition = gridBox.globalToLocal(globalPosition);

      // Determine the size of each grid cell
      double cellWidth = gridBox.size.width / 10; // Assuming 10 columns
      double cellHeight = gridBox.size.height / 10; // Assuming 10 rows

      // Print the local position for debugging purposes
      print("Global Position: $globalPosition");
      print("Local Position: $localPosition");

      // Calculate row and column based on the local position
      int row = (localPosition.dy / cellHeight).floor();
      int column = (localPosition.dx / cellWidth).floor();

      // Check if the row and column are within bounds
      if (row >= 0 && column >= 0 && row < 10 && column < 10) {
        String cellKey = "$row-$column"; // Generate a unique key for the cell

        // Update the highlight status for this cell
        setState(() {
          highlightStatus[cellKey] = true;
        });

        // Prevent double highlighting by tracking the last row and column
        if (oRow != row || oCol != column) {
          highlightedWords.add(grid[row][column]);
          oRow = row;
          oCol = column;
        }
      }
    });
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

    Future.delayed(Duration(milliseconds: 100), () {
      // Code that will run after the 1-second delay
      setState(() {
        highlightStatus.clear();
      });
      highlightedWords.clear();
    });
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

class ScreenshotArea extends StatelessWidget {
  final Widget child;
  final GlobalKey screenshotKey;

  const ScreenshotArea(
      {Key? key, required this.child, required this.screenshotKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: screenshotKey, // Use the correct GlobalKey here
      child: child,
    );
  }
}
