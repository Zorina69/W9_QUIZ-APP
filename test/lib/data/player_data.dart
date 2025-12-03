import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/player.dart';

List<PlayerModel> players = [];
PlayerModel? lastPlayer; // Store last active player

// Save players to local storage
Future<void> savePlayers() async {
  final prefs = await SharedPreferences.getInstance();
  final playerJson = players.map((p) => jsonEncode(p.toMap())).toList();
  await prefs.setStringList('players', playerJson);
}

// Save the last active player
Future<void> saveLastPlayer(PlayerModel? player) async {
  final prefs = await SharedPreferences.getInstance();
  if (player != null) {
    await prefs.setString('lastPlayer', jsonEncode(player.toMap()));
    lastPlayer = player;
  } else {
    await prefs.remove('lastPlayer');
    lastPlayer = null;
  }
}

// Load players from local storage
Future<void> loadPlayers() async {
  final prefs = await SharedPreferences.getInstance();
  final playerJson = prefs.getStringList('players') ?? [];
  players = playerJson.map((p) => PlayerModel.fromMap(jsonDecode(p))).toList();
  
  // Load last active player
  final lastPlayerJson = prefs.getString('lastPlayer');
  if (lastPlayerJson != null) {
    lastPlayer = PlayerModel.fromMap(jsonDecode(lastPlayerJson));
  }
}