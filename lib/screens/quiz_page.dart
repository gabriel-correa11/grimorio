import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../quiz_brain.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizBrain quizBrain = QuizBrain();
  List<Widget> scoreKeeper = [];
  int correctAnswers = 0;

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    int totalQuestions = 4;

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: "Fim de Jogo!",
          desc: "Você acertou $correctAnswers de $totalQuestions perguntas.",
          buttons: [
            DialogButton(
              onPressed: () {
                setState(() {
                  quizBrain.reset();
                  scoreKeeper = [];
                  correctAnswers = 0;
                });
                Navigator.pop(context);
              },
              child: const Text(
                "Recomeçar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      } else {
        if (userAnswer == correctAnswer) {
          correctAnswers++;
          scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
        } else {
          scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        QuestionDisplay(
          questionText: quizBrain.getQuestionText(),
        ),
        AnswerButton(
          buttonText: 'Verdadeiro',
          buttonColor: Colors.green,
          onPressed: () {
            checkAnswer(true);
          },
        ),
        AnswerButton(
          buttonText: 'Falso',
          buttonColor: Colors.red,
          onPressed: () {
            checkAnswer(false);
          },
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

class QuestionDisplay extends StatelessWidget {
  final String questionText;

  const QuestionDisplay({super.key, required this.questionText});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            questionText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onPressed;

  const AnswerButton({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}