import 'package:flutter/material.dart';
import '../../model/player.dart';
import '../../data/quiz_data.dart';
import '../../data/player_data.dart';
import 'result_screen.dart';
import 'welcome_screen.dart';

class QuestionScreen extends StatefulWidget {
  final PlayerModel player;

  const QuestionScreen({super.key, required this.player});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    // Reset score and answers for a new quiz
    widget.player.score = 0;
    widget.player.answers = [];
  }

  void chooseAnswer(String answer) {
    widget.player.answers.add(answer);

    // Check if correct
    if (answer == questions[index].rightAnswer) {
      widget.player.score++;
    }

    // Move to next question or finish
    if (index < questions.length - 1) {
      setState(() => index++);
    } else {
      // Save updated player score before going to result screen
      savePlayers();
      saveLastPlayer(widget.player);
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            player: widget.player,
            onBackToHome: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => WelcomeScreen(
                    onStart: (player) {
                      // Callback when user starts a new game from welcome screen
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get current question's options
    final options = answers.firstWhere((a) => a.id == questions[index].id).answers;
    final progress = (index + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.player.name}", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress Indicator
              Center(
                child: Container(
                  width: 320,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Question ${index + 1}/${questions.length}",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade400,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          "Score: ${widget.player.score}",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              
              // Progress Bar
              Center(
                child: SizedBox(
                  width: 320,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: Colors.blue.shade100,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Question Card
              Center(
                child: SizedBox(
                  width: 320,
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 8)],
                    ),
                    child: Text(
                      questions[index].question,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade900,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Answer Options
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: options.asMap().entries.map((entry) {
                      int ansIndex = entry.key;
                      String ans = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: SizedBox(
                          width: 280,
                          child: ElevatedButton(
                            onPressed: () => chooseAnswer(ans),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue.shade700,
                              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.blue.shade300, width: 1.5),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    
                                    shape: BoxShape.circle,
                                    color: Colors.blue.shade400,
                                  ),
                                  child: Center(
                                    child: Text(
                                      String.fromCharCode(65 + ansIndex), // A, B, C, D
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    ans,
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
