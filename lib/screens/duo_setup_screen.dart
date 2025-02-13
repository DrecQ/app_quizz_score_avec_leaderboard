import 'package:flutter/material.dart';

class DuoSetupScreen extends StatefulWidget {
  @override
  _DuoSetupScreenState createState() => _DuoSetupScreenState();
}

class _DuoSetupScreenState extends State<DuoSetupScreen> {
  final TextEditingController _player1Controller = TextEditingController();
  final TextEditingController _player2Controller = TextEditingController();

  void _startQuiz() {
    final String player1Name = _player1Controller.text.trim();
    final String player2Name = _player2Controller.text.trim();

    if (player1Name.isNotEmpty && player2Name.isNotEmpty) {
      Navigator.pushReplacementNamed(
        context,
        '/duoQuiz',
        arguments: {'player1Name': player1Name, 'player2Name': player2Name},
      );
    } else {
      // Affiche un message d'erreur si les noms ne sont pas remplis
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erreur'),
          content: Text('Veuillez renseigner les noms des deux joueurs.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuration du Quiz en Duo'),
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
            TextField(
              controller: _player2Controller,
              decoration: InputDecoration(labelText: 'Nom du Joueur 2'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startQuiz,
              child: Text('Commencer le Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
