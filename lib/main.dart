import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizz App',
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo-le-grand-quiz.jpg'), // Remplace par ton image
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainMenu()),
                );
              },
              child: Text('Démarrer le quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MenuButton(
              title: 'Jeu Solo',
              color: Colors.blue,
              icon: Icons.person,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SoloGame()),
                );
              },
            ),
            MenuButton(
              title: 'Jeu Multijoueur',
              color: Colors.green,
              icon: Icons.group,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MultiplayerGame()),
                );
              },
            ),
            MenuButton(
              title: 'Tableau des scores',
              color: Colors.orange,
              icon: Icons.bar_chart,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Leaderboard()),
                );
              },
            ),
            MenuButton(
              title: 'Règles du jeu',
              color: Colors.purple,
              icon: Icons.list,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameRules()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const MenuButton({
    required this.title,
    required this.color,
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(icon, size: 30),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class SoloGame extends StatefulWidget {
  @override
  _SoloGameState createState() => _SoloGameState();
}

class _SoloGameState extends State<SoloGame> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Quelle est la capitale de la France?',
      'answers': ['Paris', 'Londres', 'Berlin', 'Madrid'],
      'correctAnswer': 'Paris'
    },
    {
      'question': 'Qui a écrit "Les Misérables"?',
      'answers': ['Victor Hugo', 'Emile Zola', 'Gustave Flaubert', 'Albert Camus'],
      'correctAnswer': 'Victor Hugo'
    },
     {
      'question': 'Quel est le plus grand océan du monde?',
      'answers': ['Pacifique', 'Atlantique', 'Indien', 'Arctique'],
      'correctAnswer': 'Pacifique'
    },
    {
      'question': 'Combien de continents y a-t-il?',
      'answers': ['5', '6', '7', '8'],
      'correctAnswer': '7'
    },
    {
      'question': 'Quel est le symbole chimique de l\'or?',
      'answers': ['Au', 'Ag', 'Fe', 'Cu'],
      'correctAnswer': 'Au'
    },
    {
      'question': 'En quelle année a débuté la Première Guerre Mondiale?',
      'answers': ['1914', '1915', '1916', '1917'],
      'correctAnswer': '1914'
    },
    {
      'question': 'Qui a peint la Joconde?',
      'answers': ['Léonard de Vinci', 'Michel-Ange', 'Raphaël', 'Donatello'],
      'correctAnswer': 'Léonard de Vinci'
    },
    {
      'question': 'Quel est le plus grand pays d\'Afrique?',
      'answers': ['Algérie', 'République Démocratique du Congo', 'Soudan', 'Nigéria'],
      'correctAnswer': 'Algérie'
    },
    {
      'question': 'Quelle est la monnaie du Japon?',
      'answers': ['Yen', 'Won', 'Dollar', 'Euro'],
      'correctAnswer': 'Yen'
    },
    {
      'question': 'Quel est le nom du premier homme à avoir marché sur la lune?',
      'answers': ['Neil Armstrong', 'Buzz Aldrin', 'Michael Collins', 'Yuri Gagarin'],
      'correctAnswer': 'Neil Armstrong'
    },
    {
      'question': 'Quel est le plus long fleuve du monde?',
      'answers': ['Nil', 'Amazone', 'Yangtsé', 'Mississippi'],
      'correctAnswer': 'Nil'
    },
    {
      'question': 'Quel est l\'élément le plus abondant dans l\'univers?',
      'answers': ['Hydrogène', 'Hélium', 'Oxygène', 'Carbone'],
      'correctAnswer': 'Hydrogène'
    },
    {
      'question': 'Qui a inventé le téléphone?',
      'answers': ['Alexander Graham Bell', 'Thomas Edison', 'Nikola Tesla', 'Guglielmo Marconi'],
      'correctAnswer': 'Alexander Graham Bell'
    },
    {
      'question': 'Quelle est la capitale de l\'Italie?',
      'answers': ['Rome', 'Milan', 'Venise', 'Florence'],
      'correctAnswer': 'Rome'
    },
    {
      'question': 'Quel est le symbole chimique du fer?',
      'answers': ['Fe', 'Au', 'Ag', 'Cu'],
      'correctAnswer': 'Fe'
    },
    {
      'question': 'En quelle année a eu lieu la Révolution Française?',
      'answers': ['1789', '1799', '1815', '1848'],
      'correctAnswer': '1789'
    },
    {
      'question': 'Qui a écrit "Hamlet"?',
      'answers': ['William Shakespeare', 'Christopher Marlowe', 'Ben Jonson', 'John Milton'],
      'correctAnswer': 'William Shakespeare'
    },
    // Ajoutez plus de questions ici
  ];

  void _answerQuestion(String answer) {
    if (answer == _questions[_currentQuestionIndex]['correctAnswer']) {
      setState(() {
        _score++;
      });
    }
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _showFinalScore();
    }
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Score Final'),
          content: Text('Votre score est: $_score'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeu Solo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_questions[_currentQuestionIndex]['question']),
            ...(_questions[_currentQuestionIndex]['answers'] as List<String>).map((answer) {
              return ElevatedButton(
                onPressed: () => _answerQuestion(answer),
                child: Text(answer),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class MultiplayerGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeu Multijoueur'),
      ),
      body: Center(
        child: Text('Jeu Multijoueur - À implémenter'),
      ),
    );
  }
}

class Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> scores = [
      {'rang': 1, 'nom': 'Alice', 'score': 1200},
      {'rang': 2, 'nom': 'Bob', 'score': 1100},
      {'rang': 3, 'nom': 'Charlie', 'score': 1000},
      {'rang': 4, 'nom': 'David', 'score': 950},
      {'rang': 5, 'nom': 'Eve', 'score': 900},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau des scores'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Table(
                border: TableBorder.all(color: Colors.grey),
                children: [
                  TableRow(children: [
                    Container(padding: EdgeInsets.all(8), child: Text('Rang', style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(padding: EdgeInsets.all(8), child: Text('Nom', style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(padding: EdgeInsets.all(8), child: Text('Score', style: TextStyle(fontWeight: FontWeight.bold))),
                  ]),
                  for (var score in scores)
                    TableRow(children: [
                      Container(padding: EdgeInsets.all(8), child: Text('${score['rang']}')),
                      Container(padding: EdgeInsets.all(8), child: Text('${score['nom']}')),
                      Container(padding: EdgeInsets.all(8), child: Text('${score['score']} pts')),
                    ]),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Retour au Menu'),
            ),
          ],
        ),
      ),
    );
  }
}


class GameRules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Règles du jeu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Objectif du Jeu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Répondez correctement à un maximum de questions pour accumuler des points. Le joueur avec le plus haut score gagne !',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Déroulement du Jeu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Chaque question a un temps limité. Sélectionnez la bonne réponse parmi les options proposées.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Points',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Chaque bonne réponse vous rapporte des points. Les points varient en fonction de la difficulté de la question.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Mode Multijoueur',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Affrontez vos amis en temps réel. Le premier à répondre correctement gagne des points supplémentaires.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}


