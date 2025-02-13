import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final String players;

  GameScreen({Key? key, required this.players}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int score = 0;

  void _endGame() {
    Navigator.pushNamed(context, '/end_game', arguments: {'score': score});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeu Quiz'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Vous avez choisi: ${widget.players}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  score += 10; // Incrémentez le score pour l'exemple
                });
              },
              child: Text('Augmenter le score'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _endGame,
              child: Text('Terminer le jeu'),
            ),
          ],
        ),
      ),
    );
  }
}
