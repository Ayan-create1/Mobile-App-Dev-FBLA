import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:grammar_game/consts.dart';
import 'package:grammar_game/pages/word_search/pop_up.dart';
import '../home_page/home_page.dart';
import 'dart:math';

bool popup = true;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(
        seconds: 5,
      ),
    ),
    enableLog: true,
  );
  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: 'User', lastName: 'Naut');
  final ChatUser _gptUser = ChatUser(
    id: '2',
    firstName: 'Astro',
    lastName: 'Galaxia',
  );

  List<ChatMessage> _messages = <ChatMessage>[];

  List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    if (popup) {
      // Schedule the iWordSPopup method to run after the build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        iNeptPopup(context);
        popup = false;
      });
    }
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          color: Colors.white,
          splashRadius: 50.0,
          splashColor: Colors.black,
          iconSize: screenWidth * 0.1,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
              (route) => false,
            );
          },
        ),
        backgroundColor: Colors.deepPurple[900],
        title: const Text(
          'Speak to Astro',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            color: Colors.white,
            splashRadius: 50.0,
            splashColor: Colors.black,
            iconSize: screenWidth * 0.1,
            onPressed: () {
              iNeptPopup(context);
              print("W");
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(color: const Color(0xFF001F3F)), // Deep blue background
          const StarField(),
          AnimatedBuilder(
            animation: _waveController,
            builder: (context, child) {
              return CustomPaint(
                painter: OceanPainter(_waveController.value),
                child: Container(),
              );
            },
          ),
          DashChat(
            typingUsers: _typingUsers,
            currentUser: _currentUser,
            messageOptions: const MessageOptions(
              currentUserContainerColor: Colors.lightBlue,
              containerColor: Colors.purple,
              textColor: Colors.white,
            ),
            inputOptions: InputOptions(
              sendButtonBuilder: (onSend) {
                return IconButton(
                  icon: const Icon(Icons.send, color: Colors.yellow),
                  onPressed: onSend,
                );
              },
            ),
            onSend: (ChatMessage mes) {
              getChatResponse(mes);
            },
            messages: _messages,
          ),
        ],
      ),
    );
  }

/*
  Widget _buildAstronautAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/astro_cut.png'), 
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
  */
  Future<void> getChatResponse(ChatMessage mes) async {
    final userMessage = ChatMessage(
      user: _currentUser,
      text: mes.text,
      createdAt: DateTime.now(),
    );

    setState(() {
      _messages.insert(0, userMessage);
      _typingUsers.add(_gptUser);
    });
    final List<Map<String, String>> _messagesHistory =
        _messages.reversed.map((mes) {
      return {
        'role': mes.user == _currentUser ? 'user' : 'assistant',
        'content': mes.text,
      };
    }).toList();
    final request = ChatCompleteText(
      model: GptTurboChatModel(),
      messages: _messagesHistory,
      maxToken: 200,
    );

    final response = await _openAI.onChatCompletion(request: request);
    print("GPT response content: ${response?.choices.first.message?.content}");

    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
              0,
              ChatMessage(
                  user: _gptUser,
                  createdAt: DateTime.now(),
                  text: element.message!.content));
        });
      }
    }
    setState(() {
      _typingUsers.remove(_gptUser);
    });
  }
}

class StarField extends StatefulWidget {
  final int numberOfStars;

  const StarField({super.key, this.numberOfStars = 100});

  @override
  State<StarField> createState() => _StarFieldState();
}

class _StarFieldState extends State<StarField> {
  List<Offset> _starPositions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_starPositions.isEmpty) {
      final screenSize =
          View.of(context).physicalSize / View.of(context).devicePixelRatio;
      final random = Random();

      _starPositions = List.generate(widget.numberOfStars, (_) {
        double x = random.nextDouble() * screenSize.width;
        double y = random.nextDouble() * screenSize.height;
        return Offset(x, y);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StarPainter(_starPositions),
      child: Container(), // Fills the screen behind
    );
  }
}

class StarPainter extends CustomPainter {
  final List<Offset> stars;

  StarPainter(this.stars);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    for (var star in stars) {
      canvas.drawCircle(star, 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class OceanPainter extends CustomPainter {
  final double animationValue;

  OceanPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint()
      ..color = const Color(0xFF004466)
      ..style = PaintingStyle.fill;

    path.moveTo(0, size.height);
    for (double x = 0; x <= size.width; x++) {
      double y =
          sin((x / size.width * 2 * pi) + (animationValue * 2 * pi)) * 20 +
              size.height * 0.8;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant OceanPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
