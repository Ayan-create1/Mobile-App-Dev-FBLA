import 'package:flutter/material.dart';
import '../home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey, // Add key to Form
          child: Column(
            children: [
              SizedBox(
                height: size.height * .15,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Let’s Get Started!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: size.height * .05,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is Required';
                  }
                  if (!value.contains('@gmail.com')) {
                    return 'Email is not valid';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text('Email'),
                  hintText: 'abc@gmail.com',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange.shade400),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is Required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text('Password'),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade400),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextFormField(
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is Required';
                    }
                    if (passwordController.text.toString() != value) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text('Confirm Password'),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade400),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .05,
              ),
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      signUp(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ), // Form
      ), // Padding
    ); // Scaffold
  } // build method

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      // Attempt to create a user with the provided email and password
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('Sign Up Sucessful.')));
      print('User signed up successfully: ${credential.user?.email}');
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific exceptions
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('The password provided it too weak.')));

      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text('The account already exists for that email.')));
      } 
    } catch (e) {
      // Handle any other exceptions
      print(e);
    }
  }
} // _SignUpScreenState class
