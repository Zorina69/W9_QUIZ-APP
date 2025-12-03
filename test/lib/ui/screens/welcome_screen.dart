import 'package:flutter/material.dart';
import 'package:test/ui/screens/question_screen.dart';
import '../../model/player.dart';
import '../../data/player_data.dart'; // list of all players

typedef VoidCallBackWithPlayer = void Function(PlayerModel player);

class WelcomeScreen extends StatefulWidget {
  final VoidCallBackWithPlayer onStart;

  const WelcomeScreen({super.key, required this.onStart});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _controller = TextEditingController();
  PlayerModel? currentPlayer;
  String? errorMessage;

  final InputDecoration inputDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
      borderRadius: BorderRadius.circular(12),
    ),
    hintText: 'Enter Username',
    hintStyle: TextStyle(color: Colors.white70),
    filled: true,
    fillColor: Colors.white.withOpacity(0.2),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );

  void _verify() {
    final input = _controller.text.trim();
    if (input.isEmpty) {
      setState(() => errorMessage = "Please enter a username.");
      return;
    }

    // Check if user already exists
    PlayerModel? existing;
    try {
      existing = players.firstWhere((p) => p.name == input);
    } catch (e) {
      existing = null;
    }

    if (existing != null) {
      // Existing user
      setState(() {
        currentPlayer = existing;
        errorMessage = null;
      });
      saveLastPlayer(existing); // Save as last player
      print("Logged in existing user: ${existing.name}, score: ${existing.score}");

    } else {
      // Create a new user
      PlayerModel newPlayer = PlayerModel(name: input);
      players.add(newPlayer);
      savePlayers(); // Save to persistent storage
      saveLastPlayer(newPlayer); // Save as last player

      setState(() {
        currentPlayer = newPlayer;
        errorMessage = null;
      });
      print("Created new user: ${newPlayer.name}");
    }

    // Call callback to start game
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionScreen(player: currentPlayer!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade900, Colors.blue.shade600, Colors.purple.shade400],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with shadow
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, spreadRadius: 5),
                      ],
                    ),
                    child: Image.asset(
                      "../../assets/quiz-logo.png",
                      width: 120,
                      height: 120,
                    ),
                  ),
                  SizedBox(height: 30),
                  
                  // Title
                  Text(
                    "Quiz Master",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: Colors.black.withOpacity(0.3), blurRadius: 5)],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Test Your Knowledge",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 40),
                  
                  // Input field
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _controller,
                      decoration: inputDecoration,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 24),
                  
                  // Start button
                  SizedBox(
                    width: 150,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: _verify,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 6,
                      ),
                      child: Text(
                        "Start Game",
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  
                  // Error message
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          errorMessage!,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
