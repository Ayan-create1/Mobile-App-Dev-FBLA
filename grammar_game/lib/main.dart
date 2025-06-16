import 'package:flutter/material.dart';
//import 'package:grammar_game/pages/home_page/home_page.dart';
import 'package:grammar_game/pages/Login_page/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//! Must create android google client if we want this to work on android
//Run flutter run -t lib/another_file.dart to start the app on phone when dubgging
Future<void> main() async {
  print('Initializing Supabase');
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://oqeaphdiebfsgqtzixoj.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9xZWFwaGRpZWJmc2dxdHppeG9qIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ3NzM5ODgsImV4cCI6MjA2MDM0OTk4OH0.Xao1AABQ5FFM8-jxRIQ11umzwpnpompmB05Zedk58pQ",
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('App state changed to: $state');

    if (state == AppLifecycleState.resumed) {
      // App came back to foreground
      final session = Supabase.instance.client.auth.currentSession;
      if (session == null) {
        print("User is not logged in");
        // You might want to redirect to login or refresh session
      } else {
        print("User is still logged in");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
/*
void main() {
  runApp(MyApp());
}
*/
/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grammar Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
*/
