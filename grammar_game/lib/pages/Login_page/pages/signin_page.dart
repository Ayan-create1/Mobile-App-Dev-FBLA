import 'package:flutter/material.dart';
import 'package:grammar_game/pages/Login_page/auth_service.dart';
import 'package:grammar_game/pages/Login_page/pages/register.dart';
import "package:grammar_game/pages/AboutMe/aboutMe.dart";
import 'package:grammar_game/pages/Policy/privacy_policy.dart';
import '../../home_page/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //get auth service
  final authService = AuthService();
  bool _isGoogleLoading = false;
  final AuthService _authService = AuthService();
  //text controllers to acccess user input
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //login in button pressed
  Future<void> _signInWithGoogle() async {
    setState(() {
      _isGoogleLoading = true;
    });

    try {
      final response = await _authService.signInWithGoogle();
      if (response?.user != null) {
        // Success - AuthGate will handle navigation
        print('Successfully signed in with Google: ${response!.user!.email}');
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sign in with Google: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGoogleLoading = false;
        });
      }
    }
  }

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

            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _isGoogleLoading ? null : _signInWithGoogle,
                icon: _isGoogleLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.g_mobiledata,
                        color: Colors.white, size: 50.0),
                label: Text(
                  _isGoogleLoading ? 'Signing in...' : 'Sign in with Google',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Google's red color
                  /*shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),*/
                ),
              ),
            ),

            SizedBox(height: 20),
            // Facebook login button

            ElevatedButton.icon(
              icon: Icon(Icons.facebook, color: Colors.white, size: 30.0),
              label: Text("Sign in with Facebook",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1877F2),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () async {
                try {
                  await AuthService().signInWithFacebook();

                  // On success, navigate to HomePage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Facebook login failed: $e')),
                  );
                }
              },
            ),

            SizedBox(height: 20),

/*
          Text(
            _errorMessage,
            style: TextStyle(
              color: _errorMessage == 'Login successful!' ? Colors.green : Colors.red,
            ),
          ),
          */
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

            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PrivacyPolicyScreen()), // Replace with the correct About Me Page class
                  (route) => false, // Clears all previous routes
                );
              },
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
                    "View Privacy Policy",
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
