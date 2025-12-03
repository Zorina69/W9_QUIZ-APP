import 'package:flutter/material.dart';
import 'package:test/model/player.dart';
import 'package:test/ui/screens/welcome_screen.dart';
import 'package:test/ui/screens/question_screen.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  void _goToQuiz(PlayerModel player) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionScreen(player: player),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeScreen(
        onStart: _goToQuiz,
      ),
    );
  }
}
