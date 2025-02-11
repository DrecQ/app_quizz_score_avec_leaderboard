import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  // Données factices pour le tableau des scores
  final List<Map<String, dynamic>> scores = [
    {'name': 'Alice', 'score': 1200, 'rank': 1},
    {'name': 'Bob', 'score': 1100, 'rank': 2},
    {'name': 'Charlie', 'score': 1000, 'rank': 3},
    {'name': 'David', 'score': 950, 'rank': 4},
    {'name': 'Eve', 'score': 900, 'rank': 5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tableau des Scores',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 5,
                color: Colors.black.withOpacity(0.3),
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue.withOpacity(0.8),
        elevation: 10,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[200]!, Colors.purple[200]!],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              // En-tête du tableau
              _buildLeaderboardHeader(),
              SizedBox(height: 10),
              // Liste des scores
              Expanded(
                child: ListView.builder(
                  itemCount: scores.length,
                  itemBuilder: (context, index) {
                    return _buildScoreCard(
                      rank: scores[index]['rank'],
                      name: scores[index]['name'],
                      score: scores[index]['score'],
                    );
                  },
                ),
              ),
              // Bouton de retour
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Retour au menu
                },
                child: Text(
                  'Retour au Menu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.blue.withOpacity(0.8),
                  elevation: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // En-tête du tableau des scores
  Widget _buildLeaderboardHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Text(
            'Rang',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 40),
          Text(
            'Nom',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
          Text(
            'Score',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Carte pour afficher un score individuel
  Widget _buildScoreCard({required int rank, required String name, required int score}) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Text(
              '$rank',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 40),
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Spacer(),
            Text(
              '$score pts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}