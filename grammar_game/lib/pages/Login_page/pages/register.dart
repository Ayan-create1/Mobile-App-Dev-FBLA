import "package:flutter/material.dart";
import "package:grammar_game/pages/Login_page/auth_service.dart";
import "package:grammar_game/pages/Login_page/pages/signin_page.dart";
import "package:grammar_game/pages/home_page/home_page.dart";
import "package:supabase_flutter/supabase_flutter.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //get auth service
  final authService = AuthService();

  //text controllers to acccess user input
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  //sign up button
  void signUp() async {
    //prepare data
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmedPassword = _confirmPasswordController.text;

    //check passwords match
    if (password != confirmedPassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Passwords don't match")));
      return;
    }

    try {
      await authService.signUpWithEmailPassword(email, password);

      final user = Supabase.instance.client.auth.currentUser;

      if (user != null) {
        final response =
            await Supabase.instance.client.from('profiles').insert({
          'id': user.id,
          'points': 0,
        });

        if (response.error != null) {
          print('Error inserting profile: ${response.error!.message}');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Error creating user profile: ${response.error!.message}')));
          return;
        } else {
          print('Profile successfully created!');
        }
      }
      await Supabase.instance.client.auth.signOut();
      await authService.signInWithEmailPassword(email, password);
      //pop the register page
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Sign Up Successful! Please Exit This App and Re-enter Accessing Login Page")));
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pop(context);
      });
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
            "SIGN UP",
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
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: "Confirm Password"),
              obscureText: true,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: signUp,
              child: const Text("Sign Up"),
            ),

            SizedBox(height: 12),

            //Go to sign up page
          ],
        ));
  }
}
