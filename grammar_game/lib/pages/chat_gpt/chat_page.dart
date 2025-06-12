import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:grammar_game/consts.dart';
import '../home_page/home_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
          backgroundColor: Colors.green,
          title: const Text(
            'Speak to Astro',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: DashChat(
            typingUsers: _typingUsers,
            currentUser: _currentUser,
            messageOptions: const MessageOptions(
              currentUserContainerColor: Colors.lightBlue,
              containerColor: Colors.purple,
              textColor: Colors.white,
            ),
            onSend: (ChatMessage mes) {
              getChatResponse(mes);
            },
            messages: _messages));
  }

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
