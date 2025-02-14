import 'package:flutter/material.dart';
import '/screens/solo_screen.dart';
import '/screens/duo_screen.dart';
import '/screens/leaderboard_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Jeu de Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      routes: {
        '/solo': (context) => SoloScreen(),
        '/duo': (context) => DuoScreen(),
        '/leaderboard': (context) => LeaderboardScreen(),
        '/result': (context) => ResultScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/solo');
              },
              child: Text('Jouer en Solo'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/duo');
              },
              child: Text('Jouer en Duo'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/leaderboard');
              },
              child: Text('Tableau des Scores'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final scorePlayer1 = args['scorePlayer1'];
    final scorePlayer2 = args['scorePlayer2'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Résultats'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (scorePlayer1 != null && scorePlayer2 != null) ...[
              Text('Score du Joueur 1 : $scorePlayer1'),
              Text('Score du Joueur 2 : $scorePlayer2'),
              Text(
                scorePlayer1 > scorePlayer2
                    ? 'Le Joueur 1 gagne !'
                    : scorePlayer2 > scorePlayer1
                        ? 'Le Joueur 2 gagne !'
                        : 'Égalité !',
              ),
            ] else ...[
              Text('Votre score : ${args['score']}'),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/leaderboard');
              },
              child: Text('Voir le Tableau des Scores'),
            ),
          ],
        ),
      ),
    );
  }
}
