import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FractionCalcApp());
}

class FractionCalcApp extends StatelessWidget {
  const FractionCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trim Fraction Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
