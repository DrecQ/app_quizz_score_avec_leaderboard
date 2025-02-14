import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  final List<Player> players = [
    Player('Joueur 1', 150),
    Player('Joueur 2', 120),
    Player('Joueur 3', 100),
    Player('Joueur 4', 80),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau des scores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text(players[index].name),
                trailing: Text('${players[index].score} points'),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Player {
  final String name;
  final int score;

  Player(this.name, this.score);
}
