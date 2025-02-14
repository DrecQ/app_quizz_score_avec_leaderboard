import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  List<Question> _questions = [
    Question('Question 1', ['Option 1', 'Option 2', 'Option 3', 'Option 4'], 0),
    Question('Question 2', ['Option 1', 'Option 2', 'Option 3', 'Option 4'], 1),
    Question('Question 3', ['Option 1', 'Option 2', 'Option 3', 'Option 4'], 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _questions[_currentQuestionIndex].question,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ..._questions[_currentQuestionIndex].options.map((option) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentQuestionIndex++;
                    if (_currentQuestionIndex >= _questions.length) {
                      _currentQuestionIndex = 0;
                    }
                  });
                },
                child: Text(option),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  Question(this.question, this.options, this.correctOptionIndex);
}
