import 'package:flutter/material.dart';
import '../../model/player.dart';
import '../../data/player_data.dart';
import 'question_screen.dart';

class ResultScreen extends StatelessWidget {
  final PlayerModel player;
  final VoidCallback onBackToHome; // callback function

  const ResultScreen({
    super.key,
    required this.player,
    required this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Results", style: TextStyle(fontWeight: FontWeight.bold)),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                // Score Card
                SizedBox(
                  width: 280,
                  child: Container(
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade600],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 8)],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Your Score",
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${player.score}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 22),

                // Your Answers Section
                SizedBox(
                  width: 320,
                  child: Text(
                    "Your Answers",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 320,
                  child: Column(
                    children: player.answers.asMap().entries.map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border(left: BorderSide(width: 3, color: Colors.blue.shade400)),
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 4)],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.shade400,
                              ),
                              child: Center(
                                child: Text(
                                  "${entry.key + 1}",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(entry.value, style: TextStyle(fontSize: 13)),
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
                ),
                SizedBox(height: 22),

                // All Players Leaderboard
                SizedBox(
                  width: 320,
                  child: Text(
                    "Leaderboard",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 320,
                  child: Column(
                    children: players.asMap().entries.map((entry) {
                      final index = entry.key;
                      final p = entry.value;
                      final isCurrentPlayer = p.name == player.name;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isCurrentPlayer ? Colors.blue.shade100 : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isCurrentPlayer ? Colors.blue.shade400 : Colors.grey.shade200,
                              width: isCurrentPlayer ? 1.5 : 1,
                            ),
                            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 4)],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: index == 0 ? Colors.amber : index == 1 ? Colors.grey[400] : index == 2 ? Colors.orange[300] : Colors.blue.shade200,
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  p.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isCurrentPlayer ? Colors.blue.shade700 : Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade400,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  "${p.score}",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),

                // Action Buttons
                SizedBox(
                  width: 280,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuestionScreen(player: player),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 3,
                          ),
                          child: Text(
                            "Play Again",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 3,
                          ),
                          child: Text(
                            "New Quiz",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
