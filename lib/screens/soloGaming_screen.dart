import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoloGameScreen extends StatefulWidget {
  @override
  _SoloGameScreenState createState() => _SoloGameScreenState();
}

class _SoloGameScreenState extends State<SoloGameScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _timeLeft = 10; // Temps pour chaque question
  bool _isAnswered = false;
  bool _gameStarted = false; // Pour gérer l'état de démarrage du jeu
  String _playerName = ''; // Nom du joueur
  final TextEditingController _nameController = TextEditingController();

  // Données factices pour les questions
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Quelle est la capitale de la France ?',
      'options': ['Paris', 'Londres', 'Berlin', 'Madrid'],
      'correctAnswer': 'Paris',
    },
    {
      'question': 'Quel est le plus grand océan du monde ?',
      'options': ['Atlantique', 'Indien', 'Pacifique', 'Arctique'],
      'correctAnswer': 'Pacifique',
    },
    {
      'question': 'Qui a peint la Joconde ?',
      'options': ['Van Gogh', 'Picasso', 'Leonardo da Vinci', 'Monet'],
      'correctAnswer': 'Leonardo da Vinci',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
        _startTimer();
      } else {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _timeLeft = 10;
        _isAnswered = false;
      });
      _startTimer();
    } else {
      // Fin du jeu
      _saveScore();
      _showGameOverDialog();
    }
  }

  void _checkAnswer(String selectedAnswer) {
    if (!_isAnswered) {
      setState(() {
        _isAnswered = true;
        if (selectedAnswer ==
            questions[_currentQuestionIndex]['correctAnswer']) {
          _score += 10;
        }
      });
      Future.delayed(Duration(seconds: 1), () {
        _nextQuestion();
      });
    }
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Fin du jeu !'),
          content: Text('$_playerName, votre score final est : $_score points'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fermer la boîte de dialogue
                Navigator.pop(context); // Retour au menu
              },
              child: Text('Revenir au menu'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fermer la boîte de dialogue
                _restartGame(); // Recommencer le jeu
              },
              child: Text('Recommencer'),
            ),
          ],
        );
      },
    );
  }

  void _restartGame() {
    setState(() {
      _gameStarted = false;
      _currentQuestionIndex = 0;
      _score = 0;
      _timeLeft = 10;
      _isAnswered = false;
      _playerName = '';
      _nameController.clear();
    });
  }

  void _startGame() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez entrer votre nom')),
      );
      return;
    }
    setState(() {
      _playerName = _nameController.text;
      _gameStarted = true;
      _currentQuestionIndex = 0;
      _score = 0;
      _timeLeft = 10;
      _isAnswered = false;
    });
    _startTimer();
  }

  Future<void> _saveScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> scores = prefs.getStringList('scores') ?? [];
    scores.add('$_playerName:$_score');
    scores.sort((a, b) {
      int scoreA = int.parse(a.split(':')[1]);
      int scoreB = int.parse(b.split(':')[1]);
      return scoreB.compareTo(scoreA); // Tri décroissant
    });
    if (scores.length > 10) {
      scores =
          scores.sublist(0, 10); // Garder seulement les 10 meilleurs scores
    }
    await prefs.setStringList('scores', scores);
  }

  Future<List<String>> _getTopScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('scores') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jeu Solo',
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
          child: _gameStarted
              ? Column(
                  children: [
                    // Affichage du score
                    Text(
                      'Score: $_score',
                      style: TextStyle(
                        fontSize: 24,
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
                    SizedBox(height: 20),
                    // Timer
                    Text(
                      'Temps restant : $_timeLeft s',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Numéro de la question
                    Text(
                      'Question ${_currentQuestionIndex + 1}/${questions.length}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Question
                    Card(
                      margin: EdgeInsets.all(10),
                      elevation: 10, // Ombre plus prononcée
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Bordures plus arrondies
                        side: BorderSide(
                          color:
                              Colors.blue.withOpacity(0.5), // Bordure colorée
                          width: 2,
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 30, horizontal: 20), // Padding augmenté
                        child: Text(
                          questions[_currentQuestionIndex]['question'],
                          style: TextStyle(
                            fontSize: 26, // Taille de police augmentée
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Options de réponse
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            questions[_currentQuestionIndex]['options'].length,
                        itemBuilder: (context, index) {
                          String option = questions[_currentQuestionIndex]
                              ['options'][index];
                          String optionLabel =
                              String.fromCharCode(65 + index); // A, B, C, D
                          return GestureDetector(
                            onTap: () => _checkAnswer(option),
                            child: Card(
                              margin: EdgeInsets.all(10),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  '$optionLabel. $option',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: _isAnswered
                                        ? (option ==
                                                questions[_currentQuestionIndex]
                                                    ['correctAnswer']
                                            ? Colors.green
                                            : Colors.red)
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Entrez votre nom',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _startGame,
                      child: Text(
                        'Commencer la partie',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
}
