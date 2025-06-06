import 'package:flutter/material.dart';
import 'package:grammar_game/pages/Login_page/auth_service.dart';
import 'package:grammar_game/pages/Login_page/pages/register.dart';
import "package:grammar_game/pages/AboutMe/aboutMe.dart";

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //get auth service
  final authService = AuthService();

  //text controllers to acccess user input
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //login in button pressed
  void login() async {
    //prepare data
    final email = _emailController.text;
    final password = _passwordController.text;

    //attempt login
    try {
      await authService.signInWithEmailPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          centerTitle: true,
          title: Text(
            "LOG IN",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 50),
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),

            SizedBox(height: 12),

            ElevatedButton(
              onPressed: login,
              child: const Text("Login"),
            ),

            //!Go to sign up page
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPage())),
              child: Center(
                child: Container(
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.blue[900], // Background color
                    borderRadius: BorderRadius.circular(15), //
                  ),
                  child: Center(
                      child: Text(
                    "Make an account",
                    style: TextStyle(
                        color: Colors.white,
                        //fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                ),
              ),
            ),
            SizedBox(height: 40), // Existing spacer

// Added new button for About Me Page
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AboutMePage()), // Replace with the correct About Me Page class
                  (route) => false, // Clears all previous routes
                );
              },
              /*
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Button color
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
              ),
              */
              child: Center(
                child: Container(
                  height: 40,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.purple, // Background color
                    borderRadius: BorderRadius.circular(15), //
                  ),
                  child: Center(
                      child: Text(
                    "Go to About Me",
                    style: TextStyle(
                        color: Colors.white,
                        //fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                ),
              ),
            ),
          ],
        ));
  }
}
