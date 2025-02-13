import 'package:flutter/material.dart';
import '/screens/home_screen.dart';
import '/screens/solo_screen.dart';
import '/screens/result_screen.dart';
import '/screens/resultDuo_screen.dart';
import '/screens/duo_screen.dart';
import '/screens/duo_setup_screen.dart';
import '/screens/regle_screen.dart';
import '/screens/leaderboard_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/regle': (context) => RegleScreen(),
        '/solo': (context) => SoloScreen(),
        '/duoSetup': (context) => DuoSetupScreen(),
        '/duoQuiz': (context) => DuoScreen(),
        '/leaderboard': (context) => LeaderboardScreen(),
        '/result': (context) => ResultScreen(),
        '/resultDuo': (context) => ResultDuoScreen(),
      },
    );
  }
}
