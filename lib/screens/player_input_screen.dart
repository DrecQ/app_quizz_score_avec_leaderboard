import 'package:flutter/material.dart';
import 'resultDuo_screen.dart';

class PlayerInputScreen extends StatefulWidget {
  final bool isDuo;

  PlayerInputScreen({required this.isDuo});

  @override
  _PlayerInputScreenState createState() => _PlayerInputScreenState();
}

class _PlayerInputScreenState extends State<PlayerInputScreen> {
  final TextEditingController _player1Controller = TextEditingController();
  final TextEditingController _player2Controller = TextEditingController();

  void _startGame() {
    final String player1Name = _player1Controller.text;
    final String player2Name = widget.isDuo ? _player2Controller.text : '';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultDuoScreen(
          player1Name: player1Name,
          player2Name: player2Name,
          isDuo: widget.isDuo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isDuo
            ? 'Saisie des noms des joueurs'
            : 'Saisie du nom du joueur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _player1Controller,
              decoration: InputDecoration(labelText: 'Nom du Joueur 1'),
            ),
            if (widget.isDuo)
              TextField(
                controller: _player2Controller,
                decoration: InputDecoration(labelText: 'Nom du Joueur 2'),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startGame,
              child: Text('Commencer le Jeu'),
            ),
          ],
        ),
      ),
    );
  }
}
