import 'package:flutter/material.dart';
import 'package:grammar_game/pages/home_page/home_page.dart';
import '../word_search/ui_grid.dart';
import 'page3_tense.dart';

void main() {
  runApp(MaterialApp(
    home: Tense4Page(),
  ));
}

class Question {
  final String prompt;
  final bool answer;
  final String shown;
  Question(this.prompt, this.answer, this.shown);
}

class Tense4Page extends StatefulWidget {
  @override
  _Tense4PageState createState() => _Tense4PageState();
}

class _Tense4PageState extends State<Tense4Page> {
  final List<Question> questions = [
    Question("to come", false, "came"),
    Question("to crash", true, "crashed"),
    Question("to drive", false, "drove"),
    Question("to give", false, "gave"),
    Question("to believe", true, "believed"),
    Question("to imagine", true, "imagined"),
    Question("to ride", false, "rode"),
    Question("to drink", false, "drank"),
  ];

  int currentIndex = 0;
  String response = "";
  void check(bool guess) {
    bool right = questions[currentIndex].answer;

    setState(() {
      if (guess == right) {
        response = "✅ Correct - ${questions[currentIndex].shown}";
      } else {
        response = "❌ Incorrect - ${questions[currentIndex].shown}";
      }

      // Wait a moment before moving to the next question
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          currentIndex = (currentIndex + 1) % questions.length;
          response = "";
        });
      });
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Tense3Page(),
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
                    builder: (context) => HomePage(), // Your HomePage widget
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
              _tenseBox("One Syllable Infinitives",
                  "to go -> went\nto be -> was\nto get -> got", 100),
              _emptyContainer(10.0),
              _tenseBox("Basic Human Actions",
                  "to eat -> ate\nto think -> thought\nto speak -> spoke", 200),
              _emptyContainer(10.0),
              _tenseBox("Endings        (-ing, -ink, -ide, - eat, -ow)",
                  "to sink -> sank\nto grow -> grew\n to blow -> blew", 300),
              _emptyContainer(30.0),
              Container(
                width: MediaQuery.of(context).size.width * .95,
                decoration: BoxDecoration(
                  color: Colors.blue[900], // Background color
                  borderRadius: BorderRadius.circular(15),
                ),
                child: _game(),
              ),
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
        "Past Tense Irregulars",
        style: TextStyle(
          fontSize: 25,
          color: Colors.yellow,
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

  Widget _infoBox() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.deepPurple[900], // Background color
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: Text(
        "In English, there are often verbs that are conjugated irregularly in the past tense. They do not follow the -ed rule. Below are a couple of tricks that are helpful for identifying these verbs but are not perfect. In the end it comes down to practice",
        style: TextStyle(
          fontSize: 15,
          color: Colors.yellow[300],
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _tenseBox(String t, String x, int z) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple[900 - z], // Background color
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(7),
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.15,
            alignment: Alignment.center,
            child: Text(
              t,
              style: TextStyle(
                fontSize: 20,
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          _emptyContainerW(10.0),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.deepPurple[700 - z], // Background color
              borderRadius: BorderRadius.circular(15),
            ),
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.15,
            alignment: Alignment.center,
            child: Text(
              x,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyContainerW(double i) {
    return Container(
      width: i,
      color: Colors.transparent,
    );
  }

  Widget _game() {
    String prompt = questions[currentIndex].prompt;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              prompt,
              style: TextStyle(fontSize: 24, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed:
                      response == "Game Over!" ? null : () => check(true),
                  child: Text("Regular Verb"),
                ),
                ElevatedButton(
                  onPressed:
                      response == "Game Over!" ? null : () => check(false),
                  child: Text("Irregular Verb"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              response,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
