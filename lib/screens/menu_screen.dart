import 'package:app_quizz_score_avec_leaderboard/screens/multiPlayer_screen.dart';
import 'package:flutter/material.dart';
import 'rules_screen.dart';
import 'leaderboard_screen.dart';
import 'soloGaming_screen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu',
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
              // Option 1: Jeu Solo
              Expanded(
                child: _buildMenuButton(
                  context,
                  title: 'Jeu Solo',
                  icon: Icons.person,
                  color: Colors.blue.withOpacity(0.8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SoloGameScreen()),
                    );
                  },
                ),
              ),
              // Option 2: Jeu Multijoueur
              Expanded(
                child: _buildMenuButton(
                  context,
                  title: 'Jeu Multijoueur',
                  icon: Icons.people,
                  color: Colors.green.withOpacity(0.8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiPlayerScreen()),
                    );
                  },
                ),
              ),
              // Option 3: Tableau des Scores
              Expanded(
                child: _buildMenuButton(
                  context,
                  title: 'Tableau des Scores',
                  icon: Icons.leaderboard,
                  color: Colors.orange.withOpacity(0.8),
                  onTap: () {
                    //Navigation vers la page des scores
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LeaderboardScreen()),
                    );
                  },
                ),
              ),
              // Option 4: Règles du Jeu
              Expanded(
                child: _buildMenuButton(
                  context,
                  title: 'Règles du Jeu',
                  icon: Icons.rule,
                  color: Colors.purple.withOpacity(0.8),
                  onTap: () {
                    // Navigation vers la page des règles
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RulesScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fonction pour créer un bouton de menu stylisé
  Widget _buildMenuButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        height: 120, // Hauteur réduite des cartes
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40, // Taille de l'icône légèrement réduite
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22, // Taille de police légèrement réduite
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
            ],
          ),
        ),
      ),
    );
  }
}
