import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class DuoScreen extends StatefulWidget {
  @override
  _DuoScreenState createState() => _DuoScreenState();
}

class _DuoScreenState extends State<DuoScreen> {
  int _currentQuestionIndex = 0;
  int _scorePlayer1 = 0;
  int _scorePlayer2 = 0;
  bool _answered = false;
  int _currentPlayer = 1;
  List<Color> _answerColors = [
    Colors.blueAccent,
    Colors.blueAccent,
    Colors.blueAccent,
    Colors.blueAccent
  ];
  String player1Name = '';
  String player2Name = '';
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, String> playerNames =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    player1Name = playerNames['player1Name']!;
    player2Name = playerNames['player2Name']!;
  }

  List<Map<String, Object>> _questions = [
    {
      'questionText': 'Quelle est la capitale de la France?',
      'answers': [
        {'text': 'Paris', 'score': 1},
        {'text': 'Lyon', 'score': 0},
        {'text': 'Marseille', 'score': 0},
        {'text': 'Nice', 'score': 0},
      ],
    },
    {
      'questionText': 'Quel est le plus grand océan du monde?',
      'answers': [
        {'text': 'Atlantique', 'score': 0},
        {'text': 'Pacifique', 'score': 1},
        {'text': 'Indien', 'score': 0},
        {'text': 'Arctique', 'score': 0},
      ],
    },
    // Ajoute plus de questions ici
  ];

  void _answerQuestion(int score, int index) async {
    setState(() {
      _answered = true;
      if (_currentPlayer == 1) {
        if (score == 1) {
          _answerColors[index] = Colors.green;
          _scorePlayer1 += score;
          _audioPlayer.play(AssetSource('correct.mp3'));
        } else {
          _answerColors[index] = Colors.red;
          _audioPlayer.play(AssetSource('incorrect.mp3'));
        }
        _currentPlayer = 2;
      } else {
        if (score == 1) {
          _answerColors[index] = Colors.green;
          _scorePlayer2 += score;
          _audioPlayer.play(AssetSource('correct.mp3'));
        } else {
          _answerColors[index] = Colors.red;
          _audioPlayer.play(AssetSource('incorrect.mp3'));
        }
        _currentPlayer = 1;
        _currentQuestionIndex += 1;

        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _answered = false;
            _answerColors = [
              Colors.blueAccent,
              Colors.blueAccent,
              Colors.blueAccent,
              Colors.blueAccent
            ];
          });

          if (_currentQuestionIndex >= _questions.length) {
            _audioPlayer.play(AssetSource('end_game.mp3'));
            Navigator.pushReplacementNamed(
              context,
              '/resultDuo',
              arguments: {
                'scorePlayer1': _scorePlayer1,
                'scorePlayer2': _scorePlayer2,
                'player1Name': player1Name,
                'player2Name': player2Name
              },
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz en Duo'),
      ),
      body: _currentQuestionIndex < _questions.length
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildQuestionBox(_questions[_currentQuestionIndex]
                      ['questionText'] as String),
                  SizedBox(height: 20),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '${_currentPlayer == 1 ? player1Name : player2Name}, c\'est votre tour!',
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                  SizedBox(height: 20),
                  ...(_questions[_currentQuestionIndex]['answers']
                          as List<Map<String, Object>>)
                      .asMap()
                      .entries
                      .map((entry) {
                    int index = entry.key;
                    Map<String, Object> answer = entry.value;
                    return _buildAnswerButton(answer['text'] as String,
                        answer['score'] as int, index);
                  }).toList(),
                ],
              ),
            )
          : Center(
              child: Text(
                'Quiz terminé !',
                style: TextStyle(fontSize: 24),
              ),
            ),
    );
  }

  Widget _buildQuestionBox(String questionText) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
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
      child: Text(
        questionText,
        style: TextStyle(fontSize: 24, color: Colors.black87),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAnswerButton(String answerText, int score, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _answered ? null : () => _answerQuestion(score, index),
        style: ElevatedButton.styleFrom(
          backgroundColor: _answerColors[index],
          padding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            answerText,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
