import 'package:flutter/material.dart';
import 'word_grid.dart';

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
}

Widget _buildUI() {
  //! Maybe put this into one seperate module called display_grid
  //*Here we will get a 2D grid
  List<List<String>> grid = test();
  //*Here we create 1D array to append each row of containers to
  List<Widget> rows = [];
  //*Making a traversal to traverse through each row in the grid
  for (var row in grid) {
    //*Cells will hold each individual letter in each row of the 2D array grid
    List<Widget> cells = [];
    //*for each letter in the row
    for (var cell in row) {
      //*Here we will make a container for each cell in the row
      //!Here is where we can add the draggable property
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
    //*We will add the cells list into a row widget. Basically creating each row individually
    rows.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: cells,
      ),
    );
  }
  return Scaffold(
    backgroundColor: Colors.black,
    //*Will return a giant container full of a colum the will display each row of the 2D array
    body: Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: rows,
      ),
    ),
  );
}
