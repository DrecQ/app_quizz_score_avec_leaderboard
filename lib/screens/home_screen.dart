import 'package:flutter/material.dart';
import 'player_input_screen.dart';
import 'rules_screen.dart';

class HomeScreen extends StatelessWidget {
  void _navigateToPlayerInput(BuildContext context, bool isDuo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerInputScreen(isDuo: isDuo),
      ),
    );
  }

  void _navigateToRules(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RulesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _navigateToPlayerInput(context, false),
              child: Text('Jeu en Solo'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToPlayerInput(context, true),
              child: Text('Jeu en Duo'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToRules(context),
              child: Text('Règles du Jeu'),
            ),
          ],
        ),
      ),
    );
  }
}
