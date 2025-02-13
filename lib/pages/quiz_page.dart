import 'package:flutter/material.dart';
import '../models/question.dart';
import 'dart:math'; // <-- Ajoute ceci pour utiliser Random


class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;

  final List<Question> questions = [
    Question(
      questionText: "Flutter c'est quoi ?",
      options: ["Un language","Un Framework", "Un outil informatique", "C'est rien c'est mon petit frère"],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: "Quel widget est utilisé pour afficher du texte ?",
      options: ["Text", "Column", "Row", "Container"],
      correctAnswerIndex: 0,
    ),
     Question(
      questionText: "Quel l'indicatif du Bénin ?",
      options: ["+229", "+228", "+220", "+200"],
      correctAnswerIndex: 0,
    ),
  ];
   @override
  void initState() {
    super.initState();
    questions.shuffle(Random()); // 🔀 Mélange les questions au début
  }

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex].correctAnswerIndex) {
      setState(() {
        score += 1;
      });
    }
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex += 1;
      });
    } else {
      Navigator.pushNamed(context, "/result", arguments: score);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade300,
              Colors.purple.shade400
            ], // Dégradé bleu → violet
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SizedBox.expand(
          // <-- 🔥 Prend toute la hauteur et largeur
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  questions[currentQuestionIndex].questionText,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ...questions[currentQuestionIndex]
                    .options
                    .asMap()
                    .entries
                    .map((entry) {
                  int idx = entry.key;
                  String answer = entry.value;
                  return ElevatedButton(
                    onPressed: () => checkAnswer(idx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade700,
                    ),
                    child: Text(answer),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
