import 'package:flutter/material.dart';
import 'package:grammar_game/pages/Login_page/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://oqeaphdiebfsgqtzixoj.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9xZWFwaGRpZWJmc2dxdHppeG9qIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ3NzM5ODgsImV4cCI6MjA2MDM0OTk4OH0.Xao1AABQ5FFM8-jxRIQ11umzwpnpompmB05Zedk58pQ",
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
