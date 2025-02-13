import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultPage extends StatefulWidget {
  final int score;

  ResultPage({required this.score});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<int> leaderboard = [];

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();
  }

  // Charger les scores enregistrés
  Future<void> _loadLeaderboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? scores = prefs.getStringList('leaderboard');

    if (scores != null) {
      setState(() {
        leaderboard = scores.map((e) => int.parse(e)).toList();
      });
    }

    _saveScore();
  }

  // Sauvegarder le nouveau score
  Future<void> _saveScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    leaderboard.add(widget.score);
    leaderboard.sort((b, a) => a.compareTo(b)); // Trier en ordre décroissant
    if (leaderboard.length > 10) {
      leaderboard = leaderboard.sublist(0, 10); // Garder seulement le Top 10
    }

    await prefs.setStringList('leaderboard', leaderboard.map((e) => e.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Résultat')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Votre score : ${widget.score}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/leaderboard");
              },
              child: Text("Voir le leaderboard"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/");
              },
              child: Text("Rejouer"),
            ),
          ],
        ),
      ),
    );
  }
}
