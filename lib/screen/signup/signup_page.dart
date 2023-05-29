import 'package:flixflex/screen/signup/signup_from.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0c0f3b),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SignUpForm(),
      ),
    );
  }
}
