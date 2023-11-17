import 'package:flutter/material.dart';
import 'package:password_generator/const/const.dart';
import 'package:firebase_core/firebase_core.dart'; // Import the Firebase Core package

import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for FlutterFire

  // Initialize Firebase
  await Firebase.initializeApp();
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
          seedColor: GreenColor,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        password: '',
      ),
    );
  }
}
