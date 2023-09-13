import 'package:flutter/material.dart';
import 'package:password_generator/onboarding.dart';

import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 58, 18, 6),
        ),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}
