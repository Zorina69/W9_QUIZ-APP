import 'package:flutter/material.dart';
import 'package:test/ui/quiz_app.dart';
import 'package:test/data/player_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadPlayers(); // Load saved players on app startup
  runApp(MaterialApp(
    home: QuizApp(),
    debugShowCheckedModeBanner: false,
  ));
}
