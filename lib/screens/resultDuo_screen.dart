import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ResultDuoScreen extends StatefulWidget {
  final String player1Name;
  final String player2Name;
  final bool isDuo;

  ResultDuoScreen({
    required this.player1Name,
    required this.player2Name,
    required this.isDuo,
  });

  @override
  _ResultDuoScreenState createState() => _ResultDuoScreenState();
}

class _ResultDuoScreenState extends State<ResultDuoScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlayer1Turn = true;
  bool gameEnded = false;
  int turnCount = 0; // Compteur pour suivre le nombre de tours
  int scorePlayer1 = 0;
  int scorePlayer2 = 0;

  List<Map<String, dynamic>> players = [];

  @override
  void initState() {
    super.initState();
    players.add({
      'name': widget.player1Name,
      'score': 0,
      'isWinner': false,
    });
    if (widget.isDuo) {
      players.add({
        'name': widget.player2Name,
        'score': 0,
        'isWinner': false,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Jouer un son de résultat à la fin du jeu
    if (gameEnded) {
      _audioPlayer.play(AssetSource('end_game.mp3'));

      // Déterminer les mentions pour les joueurs
      String mentionPlayer1 = scorePlayer1 > scorePlayer2
          ? 'Gagnant'
          : scorePlayer1 < scorePlayer2
              ? 'Perdant'
              : 'Égalité';
      String mentionPlayer2 = scorePlayer2 > scorePlayer1
          ? 'Gagnant'
          : scorePlayer2 < scorePlayer1
              ? 'Perdant'
              : 'Égalité';

      // Mettre à jour les scores et les mentions dans la liste des joueurs
      players[0]['score'] = scorePlayer1;
      players[0]['isWinner'] = mentionPlayer1 == 'Gagnant';
      if (widget.isDuo) {
        players[1]['score'] = scorePlayer2;
        players[1]['isWinner'] = mentionPlayer2 == 'Gagnant';
      }

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
                Text(
                  '${widget.player1Name}, votre score :',
                  style: TextStyle(fontSize: 22, color: Colors.deepPurple),
                ),
                Text(
                  '$scorePlayer1',
                  style: TextStyle(fontSize: 22, color: Colors.blueAccent),
                ),
                Text(
                  '$mentionPlayer1',
                  style: TextStyle(fontSize: 18, color: Colors.green),
                ),
                if (widget.isDuo) ...[
                  SizedBox(height: 20),
                  Text(
                    '${widget.player2Name}, votre score :',
                    style: TextStyle(fontSize: 22, color: Colors.deepPurple),
                  ),
                  Text(
                    '$scorePlayer2',
                    style: TextStyle(fontSize: 22, color: Colors.blueAccent),
                  ),
                  Text(
                    '$mentionPlayer2',
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                ],
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Retour'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Variables pour le joueur en cours
    String currentPlayerName =
        isPlayer1Turn ? widget.player1Name : widget.player2Name;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tour de jeu'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tour de $currentPlayerName !',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Simuler l'augmentation du score
                    if (isPlayer1Turn) {
                      scorePlayer1 += 1;
                    } else {
                      scorePlayer2 += 1;
                    }

                    // Passer au joueur suivant
                    isPlayer1Turn = !isPlayer1Turn;
                    turnCount += 1;

                    // Condition de fin de jeu après 10 tours (5 pour chaque joueur)
                    if (turnCount >= 10) {
                      gameEnded = true;
                    }
                  });
                },
                child: Text('Jouer pour $currentPlayerName'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Retour'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
