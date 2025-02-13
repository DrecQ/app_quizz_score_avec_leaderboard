class Question {
  final String text; // Texte de la question
  final List<String> options; // Options de réponse
  final int
      correctAnswerIndex; // Index de la bonne réponse dans la liste options

  Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });

  // Méthode pour vérifier si la réponse donnée est correcte
  bool isCorrect(int answerIndex) {
    return answerIndex == correctAnswerIndex;
  }
}
