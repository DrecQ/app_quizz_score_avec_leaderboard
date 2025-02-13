import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<int> leaderboard = [];

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? scores = prefs.getStringList('leaderboard');

    if (scores != null) {
      setState(() {
        leaderboard = scores.map((e) => int.parse(e)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Leaderboard")),
      body: Center(
        child: leaderboard.isEmpty
            ? Text("Aucun score enregistré", style: TextStyle(fontSize: 18))
            : ListView.builder(
                itemCount: leaderboard.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text("#${index + 1}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    title: Text("Score: ${leaderboard[index]}", style: TextStyle(fontSize: 18)),
                  );
                },
              ),
      ),
    );
  }
}
