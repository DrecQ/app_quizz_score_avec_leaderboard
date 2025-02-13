import 'package:flutter/material.dart';

class SoloScreen extends StatefulWidget {
  @override
  _SoloScreenState createState() => _SoloScreenState();
}

class _SoloScreenState extends State<SoloScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _answered = false;
  List<Color> _answerColors = [
    Colors.blueAccent,
    Colors.blueAccent,
    Colors.blueAccent,
    Colors.blueAccent
  ];

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

  void _answerQuestion(int score, int index) {
    setState(() {
      _answered = true;
      if (score == 1) {
        _answerColors[index] = Colors.green;
        _score += score;
      } else {
        _answerColors[index] = Colors.red;
      }

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _currentQuestionIndex += 1;
          _answered = false;
          _answerColors = [
            Colors.blueAccent,
            Colors.blueAccent,
            Colors.blueAccent,
            Colors.blueAccent
          ];
        });

        if (_currentQuestionIndex >= _questions.length) {
          // Naviguer vers l'écran des résultats
          Navigator.pushReplacementNamed(context, '/result', arguments: _score);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz en Solo'),
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
