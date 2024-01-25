import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:my_playground/features/user/presentation/widgets/button.dart";
import "package:my_playground/features/user/presentation/widgets/text_input.dart";

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future signUp(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
              controller: _firstNameController,
              hintText: 'First Name',
            ),
            const SizedBox(height: 16.0),
            TextInput(
              controller: _lastNameController,
              hintText: 'Last Name',
            ),
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
              onPressed: () => _onRegisterButtonPressed(context),
              text: 'Register',
            ),
            const SizedBox(height: 16.0),
            Button(
              onPressed: () => _onLoginViewTapped(context),
              text: 'Back to Login',
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  void _onRegisterButtonPressed(BuildContext context) {
    signUp(_emailController.text.trim(), _passwordController.text.trim()).then(
      (value) => Navigator.pushNamed(context, '/Login'),
    );
  }

  void _onLoginViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/Login');
  }
}
