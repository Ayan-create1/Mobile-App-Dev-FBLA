import 'package:flutter/material.dart';
import 'package:grammar_game/pages/home_page/home_page.dart';
import '../word_search/ui_grid.dart';
import 'page2_tense.dart';
import 'page4_tense.dart';

class Tense3Page extends StatefulWidget {
  @override
  _Tense3PageState createState() => _Tense3PageState();
}

class _Tense3PageState extends State<Tense3Page> {
  final List<Map<String, String>> prompts = [
    {'prompt': 'to fall - future', 'answer': 'will fall'},
    {'prompt': 'to have - conditional (would)', 'answer': 'would have'},
    {'prompt': 'to laugh - past', 'answer': 'laughed'},
    {'prompt': 'to sound - present', 'answer': 'sound'},
    {'prompt': 'to fail - past', 'answer': 'failed'},
    {'prompt': 'to run - future', 'answer': 'will run'},
    {'prompt': 'to eat - present', 'answer': 'eat'},
    {'prompt': 'to fix - conditional (might)', 'answer': 'might fix'},
  ];

  int currentIndex = 0;
  String userAnswer = '';
  String checkMessage = '';

  final TextEditingController _controller = TextEditingController();

  void check() {
    String correctAnswer =
        prompts[currentIndex]['answer']!.toLowerCase().trim();
    String input = userAnswer.toLowerCase().trim();
    setState(() {
      if (input == correctAnswer) {
        checkMessage = '✅ Correct!';
      } else {
        checkMessage =
            '❌ Incorrect! - Answer: ${prompts[currentIndex]['answer']!}';
      }

      currentIndex = (currentIndex + 1) % prompts.length;
      _controller.clear();
      userAnswer = '';
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
                    builder: (context) => Tense2Page(),
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
                    builder: (context) => Tense4Page(), // Your HomePage widget
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
              _tenseBox(
                  "Present",
                  "Take the infinitive and take off the <to>\nEx: to swim -> swim",
                  0),
              _emptyContainer(10.0),
              _tenseBox(
                  "Past",
                  "Take off the <to> from the infinitive and add <ed> to the result\nEx: to walk -> walked",
                  100),
              _emptyContainer(10.0),
              _tenseBox(
                  "Future",
                  "Take off the <to> from the infinitive and add <will> to the beginning of the result\nEx: to eat -> will eat",
                  200),
              _emptyContainer(10.0),
              _tenseBox(
                  "Conditional",
                  "Take off the <to> from the infinitive and add a word signaling possibility (would, could)\nEx: to fight -> could fight",
                  300),
              _emptyContainer(20.0),
              Container(
                width: MediaQuery.of(context).size.width * .95,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue, // Background color
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                child: _practice(),
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

  Widget _practice() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Practice!",
            style: TextStyle(
              fontSize: 25,
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          _emptyContainer(5.0),
          Text(
            "Type in the correct conjugation for the given word into the answer box and check your answer. Please note that words will cycle through and eventually repeat",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          _emptyContainer(10.0),
          // Prompt Box
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.lightBlue[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              prompts[currentIndex]['prompt']!,
              style: TextStyle(fontSize: 17),
            ),
          ),
          SizedBox(height: 20),

          // Answer Input
          Container(
            width: MediaQuery.of(context).size.width * .85,
            decoration: BoxDecoration(
              color: Colors.lightBlue[100], // Background color
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            child: TextField(
              controller: _controller,
              onChanged: (value) => userAnswer = value,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your answer...',
              ),
            ),
          ),
          SizedBox(height: 10),

          // Submit Button
          ElevatedButton(
            onPressed: check,
            child: Text('Submit'),
          ),

          SizedBox(height: 5),

          // Result Message
          Text(
            checkMessage,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  Widget _emptyContainerW(double i) {
    return Container(
      width: i,
      color: Colors.transparent,
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
            width: MediaQuery.of(context).size.width * 0.35,
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
              color: Colors.blue[700 - z], // Background color
              borderRadius: BorderRadius.circular(15),
            ),
            width: MediaQuery.of(context).size.width * 0.57,
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

  Widget _title() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.center,
      child: Text(
        "Conjugation Patterns",
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
        color: Colors.blue[900], // Background color
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: Text(
        "Read about how to conjugate these different tense verbs and then try the conjugation activity",
        style: TextStyle(
          fontSize: 15,
          color: Colors.yellow[300],
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
