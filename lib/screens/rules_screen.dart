import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Règles du Jeu',
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
          child: ListView(
            children: [
              // Règle 1 : Objectif du jeu
              _buildRuleCard(
                icon: Icons.flag,
                title: 'Objectif du Jeu',
                description:
                    'Répondez correctement à un maximum de questions pour accumuler des points. Le joueur avec le plus haut score gagne !',
              ),
              // Règle 2 : Déroulement du jeu
              _buildRuleCard(
                icon: Icons.play_circle_filled,
                title: 'Déroulement du Jeu',
                description:
                    'Chaque question a un temps limité. Sélectionnez la bonne réponse parmi les options proposées.',
              ),
              // Règle 3 : Points
              _buildRuleCard(
                icon: Icons.star,
                title: 'Points',
                description:
                    'Chaque bonne réponse vous rapporte des points. Les points varient en fonction de la difficulté de la question.',
              ),
              // Règle 4 : Mode Multijoueur
              _buildRuleCard(
                icon: Icons.people,
                title: 'Mode Multijoueur',
                description:
                    'Affrontez vos amis en temps réel. Le premier à répondre correctement gagne des points supplémentaires.',
              ),
              // Règle 5 : Tableau des Scores
              _buildRuleCard(
                icon: Icons.leaderboard,
                title: 'Tableau des Scores',
                description:
                    'Consultez le classement des meilleurs joueurs et essayez de vous hisser en haut du tableau !',
              ),
              // Bouton de retour
              SizedBox(height: 20),
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

  // Fonction pour créer une carte de règle
  Widget _buildRuleCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.blue,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
