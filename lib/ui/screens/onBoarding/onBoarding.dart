import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  static const String path = '/onboarding';
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Onboarding Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}