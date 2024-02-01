import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_playground/features/user/presentation/widgets/button.dart';
import 'package:my_playground/features/user/presentation/widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            TextInput(
              controller: _emailController,
              hintText: 'Email',
            ),
            const SizedBox(height: 16.0),
            TextInput(
              controller: _passwordController,
              hintText: 'Password',
            ),
            const SizedBox(height: 16.0),
            Button(
              onPressed: () => _onLoginButtonPressed(context),
              text: 'Login',
            ),
            const SizedBox(height: 16.0),
            Button(
              onPressed: () => _onRegisterViewTapped(context),
              text: 'Register',
            ),
            const SizedBox(height: 16.0),
            Button(
              onPressed: () => _onContinueViewTapped(context),
              text: 'Continue as Guest',
            ),
            const SizedBox(height: 16.0),
            Button(
              onPressed: () => _onGameViewTapped(context),
              text: 'Play Game',
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  void _onLoginButtonPressed(BuildContext context) {
    signIn(_emailController.text.trim(), _passwordController.text.trim()).then(
      (value) => Navigator.pushNamed(context, '/ViewDevices'),
    );
  }

  void _onRegisterViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/Register');
  }

  void _onContinueViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/ViewDevices');
  }

  void _onGameViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/PlayGame');
  }
}
