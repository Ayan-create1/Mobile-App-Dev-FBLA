import 'package:flutter/material.dart';
import 'package:grammar_game/pages/Login_page/pages/signin_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../home_page/home_page.dart';
/*
AuthGate will look for change in state
unauthenticated --> Login Page
authenticated --> Profile Page
*/

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        //check if there is a valid session
        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null) {
          return const HomePage();
        } else {
          return const SignInPage();
        }
      },
    );
  }
}
