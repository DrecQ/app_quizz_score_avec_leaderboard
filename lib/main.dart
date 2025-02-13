import 'package:flutter/material.dart';
import 'pages/quiz_page.dart';
import 'pages/result_page.dart';
import 'pages/leaderboard_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => QuizPage(),
        '/result': (context) => ResultPage(score: ModalRoute.of(context)!.settings.arguments as int),
        '/leaderboard': (context) => LeaderboardPage(),
      },
    );
  }
}
