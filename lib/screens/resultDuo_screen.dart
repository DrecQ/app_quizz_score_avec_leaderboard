import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ResultDuoScreen extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> scores =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int scorePlayer1 = scores['scorePlayer1'] as int;
    final int scorePlayer2 = scores['scorePlayer2'] as int;
    final String player1Name = scores['player1Name'] as String;
    final String player2Name = scores['player2Name'] as String;

    // Jouer un son de résultat
    _audioPlayer.play(AssetSource('end_game.mp3'));

    // Déterminer les mentions pour les joueurs
    String mentionPlayer1 = scorePlayer1 > scorePlayer2 ? 'Gagnant' : 'Perdant';
    String mentionPlayer2 = scorePlayer2 > scorePlayer1 ? 'Gagnant' : 'Perdant';

    return Scaffold(
      appBar: AppBar(
        title: Text('Résultats du Quiz en Duo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Quiz terminé !',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    '$player1Name, votre score :',
                    textStyle:
                        TextStyle(fontSize: 22, color: Colors.deepPurple),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
              Text(
                '$scorePlayer1',
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              Text(
                mentionPlayer1,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(height: 20),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    '$player2Name, votre score :',
                    textStyle:
                        TextStyle(fontSize: 22, color: Colors.deepPurple),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
              Text(
                '$scorePlayer2',
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              Text(
                mentionPlayer2,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text('Retour à l\'Accueil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
