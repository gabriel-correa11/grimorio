class QuizBrain {
  int _questionNumber = 0;

  final List<String> _questions = [
    'O livro "Dom Quixote" foi escrito por Machado de Assis.',
    'A série "Harry Potter" tem 7 livros.',
    '"O Pequeno Príncipe" começa com o desenho de uma jiboia que engoliu um elefante.',
    'George Orwell escreveu "1984" e "A Revolução dos Bichos".'
  ];

  final List<bool> _answers = [
    false,
    true,
    true,
    true,
  ];

  void nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questions[_questionNumber];
  }

  bool getCorrectAnswer() {
    return _answers[_questionNumber];
  }

  bool isFinished() {
    return _questionNumber >= _questions.length - 1;
  }

  void reset() {
    _questionNumber = 0;
  }
}