import 'package:flutter/material.dart';
import '../grammar_module/page2.dart';
import 'package:grammar_game/pages/home_page/home_page.dart';
import '../drag_and_drop/matching.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Interactive Grammar Module',
    theme: ThemeData(
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: Colors.orange.shade50,
      appBarTheme: AppBarTheme(
        color: Colors.red.shade600,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade400,
          foregroundColor: Colors.white,
        ),
      ),
    ),
    home: NonEssentialClausesPage(),
  ));
}

class NonEssentialClausesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Non-Essential Clauses & Dashes'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange[300], // Customize the background color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Align buttons in the center
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
                    builder: (context) => GrammarApp(), // Correctly reference GrammarApp
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
                    builder: (context) => DragAndDropGame(), // Correctly reference DragAndDropGame
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
                    builder: (context) => HomePage(), // Correctly reference HomePage
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Non-Essential Clauses Module!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PracticeConceptsPage()),
                );
              },
              child: Text('Practice Concepts'),
            ),
          ],
        ),
      ),
    );
  }
}

class PracticeConceptsPage extends StatefulWidget {
  @override
  _PracticeConceptsPageState createState() => _PracticeConceptsPageState();
}

class _PracticeConceptsPageState extends State<PracticeConceptsPage> {
  int _score = 0;
  Map<String, String> _answers = {};

  // Questions for Drag-and-Drop
  final List<Map<String, dynamic>> _questions = [
    {
      'sentence': 'The Great Wall of China ___ which is very old ___ stretches for thousands of miles.',
      'correctAnswer': 'Comma (,)',
    },
    {
      'sentence': 'The Eiffel Tower ___ located in Paris ___ is a popular tourist spot.',
      'correctAnswer': 'Dash (—)',
    },
    {
      'sentence': 'The car sped down the highway.',
      'task': 'Identify the subject',
      'correctAnswer': 'The car',
    },
    {
      'sentence': 'The bird sang a melodious song.',
      'task': 'Identify the verb',
      'correctAnswer': 'sang',
    },
  ];

  // Drag-and-Drop Targets
  final List<String> _targets = [
    'Comma (,)',
    'Dash (—)',
    'The car',
    'sang',
  ];

  void _checkAnswers() {
    setState(() {
      _score = 0;
      _questions.forEach((question) {
        if (_answers[question['sentence']] == question['correctAnswer']) {
          _score++;
        }
      });
    });
  }

  void _resetGame() {
    setState(() {
      _answers.clear();
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice Concepts'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: ListView(
              padding: EdgeInsets.all(20),
              children: _questions.map((question) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question['sentence'],
                        style: TextStyle(fontSize: 16),
                      ),
                      if (question.containsKey('task'))
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            'Task: ${question['task']}',
                            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                          ),
                        ),
                      SizedBox(height: 10),
                      DragTarget<String>(
                        builder: (context, candidateItems, rejectedItems) {
                          return Container(
                            color: Colors.orange.shade200,
                            padding: EdgeInsets.all(10),
                            height: 40,
                            width: double.infinity,
                            child: Text(
                              _answers[question['sentence']] ?? 'Drag here',
                              style: TextStyle(fontSize: 14),
                            ),
                          );
                        },
                        onAccept: (data) {
                          setState(() {
                            _answers[question['sentence']] = data;
                          });
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Divider(color: Colors.red, thickness: 2),
          Expanded(
            flex: 1,
            child: ListView(
              padding: EdgeInsets.all(10),
              children: _targets.map((target) {
                return Draggable<String>(
                  data: target,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      target,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  feedback: Material(
                    child: Container(
                      color: Colors.orange,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        target,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _checkAnswers,
                  child: Text('Check Answers'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _resetGame,
                  child: Text('Reset'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade300),
                ),
                SizedBox(height: 10),
                Text(
                  'Your Score: $_score/${_questions.length}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}