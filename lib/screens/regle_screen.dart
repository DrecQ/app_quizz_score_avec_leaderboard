import 'package:flutter/material.dart';

class RegleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Règles du Jeu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Règles du Jeu de Quiz',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              _buildRuleBox(
                context,
                '1. Mode Solo',
                '   • Répondez aux questions une par une.\n'
                    '   • Chaque réponse correcte vous rapporte des points.\n'
                    '   • À la fin du quiz, votre score final est affiché.\n'
                    '   • Vous pouvez rejouer pour améliorer votre score.',
                Colors.blue[100]!,
              ),
              SizedBox(height: 16),
              _buildRuleBox(
                context,
                '2. Mode Multi-joueur (optionnel)',
                '   • Deux joueurs ou plus peuvent jouer en même temps.\n'
                    '   • Les joueurs répondent aux mêmes questions.\n'
                    '   • À la fin, les scores sont comparés pour déterminer le gagnant.',
                Colors.green[100]!,
              ),
              SizedBox(height: 16),
              _buildRuleBox(
                context,
                '3. Classement (Leaderboard)',
                '   • Vos scores sont sauvegardés après chaque jeu.\n'
                    '   • Les 5 meilleurs scores sont affichés dans le classement.\n'
                    '   • Utilisez vos compétences pour entrer dans le top 5 !',
                Colors.orange[100]!,
              ),
              SizedBox(height: 16),
              _buildRuleBox(
                context,
                '4. Expérience utilisateur',
                '   • Profitez d\'animations fluides et de transitions dynamiques.\n'
                    '   • Un son est joué après chaque clic pour une expérience interactive.\n'
                    '   • Interface utilisateur moderne et attrayante avec Google Fonts.',
                Colors.red[100]!,
              ),
              SizedBox(height: 16),
              _buildRuleBox(
                context,
                'Amusez-vous et essayez de battre vos propres scores !',
                '',
                Colors.deepPurple[100]!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRuleBox(
      BuildContext context, String title, String content, Color color) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            if (content.isNotEmpty) ...[
              SizedBox(height: 8),
              Text(
                content,
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
