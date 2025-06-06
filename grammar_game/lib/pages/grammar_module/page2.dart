import 'package:flutter/material.dart';
import '../drag_and_drop/matching.dart';
import '../grammar_module/page3.dart';
import '../grammar_module/page2.dart';
import '../grammar_module/page1.dart';
import 'package:grammar_game/pages/home_page/home_page.dart';

void main() {
  runApp(GrammarApp());
}

class GrammarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            foregroundColor: Colors.white, // Button text color
          ),
        ),
      ),
      home: GrammarHomePage(),
    );
  }
}

class GrammarHomePage extends StatefulWidget {
  @override
  _GrammarHomePageState createState() => _GrammarHomePageState();
}

class _GrammarHomePageState extends State<GrammarHomePage> {
  int _currentLearningIndex = 0;
  int _currentQuizIndex = 0;
  int _score = 0;
  bool _inQuizMode = false;
  bool _quizCompleted = false;

  // Learning Section Content
  final List<Map<String, Object>> _learningContent = [
    {
      'rule': 'Comma (,)',
      'description':
          'Used to separate items in a list or clauses in a sentence.',
      'example': 'Example: "I bought apples, oranges, and bananas."',
    },
    {
      'rule': 'Semicolon (;)',
      'description':
          'Links closely related ideas or separates items \nin a list when the items contain commas.',
      'example':
          'Example: "We visited Paris, France; \nRome, Italy; and Berlin, Germany."',
    },
    {
      'rule': 'Colon (:)',
      'description': 'Introduces a list, explanation, or further information.',
      'example':
          'Example: "She brought three things: \na notebook, a pen, and her phone."',
    },
  ];

  // Quiz Section Content
  final List<Map<String, Object>> _quizContent = [
    {
      'questionText':
          'Which punctuation is correct? "I bought apples__ oranges__ bananas."',
      'options': [',', ';', ':'],
      'answer': ',',
    },
    {
      'questionText':
          'Which punctuation is correct? "We visited New York, USA__ Los Angeles, USA__ and Chicago, USA."',
      'options': [';', ',', '.'],
      'answer': ';',
    },
    {
      'questionText':
          'Which punctuation is correct? "She brought three things__ a bag, a book, and her phone."',
      'options': [':', ',', ';'],
      'answer': ':',
    },
  ];

  void _nextLearningPage() {
    setState(() {
      if (_currentLearningIndex < _learningContent.length - 1) {
        _currentLearningIndex++;
      }
    });
  }

  void _prevLearningPage() {
    setState(() {
      if (_currentLearningIndex > 0) {
        _currentLearningIndex--;
      }
    });
  }

  void _startQuiz() {
    setState(() {
      _inQuizMode = true;
      _currentQuizIndex = 0;
      _score = 0; // Reset score for a fresh quiz
      _quizCompleted = false;
    });
  }

  void _answerQuizQuestion(String selectedOption) {
    setState(() {
      if (_quizContent[_currentQuizIndex]['answer'] == selectedOption) {
        _score++;
      }
      if (_currentQuizIndex < _quizContent.length - 1) {
        _currentQuizIndex++;
      } else {
        _quizCompleted = true; // Mark quiz as completed
      }
    });
  }

  void _retryQuiz() {
    setState(() {
      _currentQuizIndex = 0;
      _score = 0;
      _quizCompleted = false;
    });
  }

  void _returnToLearning() {
    setState(() {
      _inQuizMode = false;
      _currentLearningIndex = 0; // Reset learning progress
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Punctuation Practice'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    builder: (context) => GrammarModule(),
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
                    builder: (context) => DragAndDropGame(),
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
                    builder: (context) => HomePage(),
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
                    builder: (context) => NonEssentialClausesPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _inQuizMode
          ? _quizCompleted
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Quiz Completed!\nYour Score: $_score/${_quizContent.length}',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _retryQuiz,
                        child: Text('Retry Quiz'),
                      ),
                      ElevatedButton(
                        onPressed: _returnToLearning,
                        child: Text('Back to Learning'),
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _quizContent[_currentQuizIndex]['questionText'] as String,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ...(_quizContent[_currentQuizIndex]['options']
                            as List<String>)
                        .map((option) {
                      return ElevatedButton(
                        onPressed: () => _answerQuizQuestion(option),
                        child: Text(option),
                      );
                    }).toList(),
                    ElevatedButton(
                      onPressed: _returnToLearning,
                      child: Text('Back to Learning'),
                    ),
                  ],
                )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Rule: ${_learningContent[_currentLearningIndex]['rule']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  _learningContent[_currentLearningIndex]['description']
                      as String,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  _learningContent[_currentLearningIndex]['example'] as String,
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                if (_currentLearningIndex == _learningContent.length - 1)
                  ElevatedButton(
                    onPressed: _startQuiz,
                    child: Text('Try Quiz'),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (_currentLearningIndex > 0)
                      ElevatedButton(
                        onPressed: _prevLearningPage,
                        child: Text('Back'),
                      ),
                    if (_currentLearningIndex < _learningContent.length - 1)
                      ElevatedButton(
                        onPressed: _nextLearningPage,
                        child: Text('Next'),
                      ),
                  ],
                ),
              ],
            ),
    );
  }
}
