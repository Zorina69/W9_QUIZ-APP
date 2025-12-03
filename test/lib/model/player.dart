class PlayerModel {
  String name;
  int score;
  List<String> answers;

  PlayerModel({
    required this.name,
    this.score = 0,
    List<String>? answers,
  }) : answers = answers ?? [];

  // Convert PlayerModel to Map for JSON serialization
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
      'answers': answers,
    };
  }

  // Create PlayerModel from Map
  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      name: map['name'] ?? '',
      score: map['score'] ?? 0,
      answers: List<String>.from(map['answers'] ?? []),
    );
  }
}
