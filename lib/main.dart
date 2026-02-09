import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CristinaKidsApp());
}

class CristinaKidsApp extends StatelessWidget {
  const CristinaKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CristinaKids',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}
