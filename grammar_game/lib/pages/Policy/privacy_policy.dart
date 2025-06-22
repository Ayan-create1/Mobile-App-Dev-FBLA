import 'package:flutter/material.dart';
import 'package:grammar_game/pages/Login_page/auth_gate.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => AuthGate()),
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Last updated: June 20, 2025',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Thank you for playing Space Words. Your privacy is important to us. This Privacy Policy explains our security and accessibility policies, what data we collect, how we use it, and your rights regarding your personal information.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              _buildSection(
                '1. Data Integrity & Security',
                'We use Supabase to store our users data:\n• It is a ACID Compliant Postgres SQL\n• Uses AES-256 end to end encryption\n• Row Level Security',
              ),
              _buildSection(
                '2. Accessibility',
                'Users can only view and access their own data thanks to our Row Level Security policies.',
              ),
              _buildSection(
                '3. Information We Collect',
                'When you use Facebook or Google Login to access Space Words, we may collect the following information:\n• Your name\n• Your email address\n\nWe do not collect passwords or personal messages.\n\nWhen you use Email Password authentication, developers cannot see your password thanks to Supabase encryption.',
              ),
              _buildSection(
                '4. How We Use Your Data',
                'We use your information to:\n• Authenticate you into the app\n• Track your game progress, unlocked items, and preferences\n\nWe do not sell or share your data with third parties.',
              ),
              _buildSection(
                '5. Data Retention',
                'We retain your data as long as you use the app. You may request deletion of your data at any time (see below).',
              ),
              _buildSection(
                '6. Data Deletion',
                'To request deletion of your data, please contact us at:\n2ayanagarwal09@gmail.com\n\nSubject: Data Deletion Request\n\nPlease include your name and the email used with Facebook Login.',
              ),
              _buildSection(
                '7. Changes to This Policy',
                'We may update this policy from time to time. Any changes will be posted on this page with the updated date.',
              ),
              _buildSection(
                '8. Contact Us',
                'If you have questions about this policy, email us at:\n2ayanagarwal09@gmail.com',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.yellow,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
