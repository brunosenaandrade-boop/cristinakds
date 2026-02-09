import 'package:shared_preferences/shared_preferences.dart';

/// Gerencia o progresso do jogador (níveis desbloqueados + estrelas)
/// Suporta múltiplos jogos via [gameType]: 'memory' ou 'ws' (word search)
class GameProgress {
  static String _keyMaxLevel(String gameType) => '${gameType}_max_level_unlocked';
  static String _keyStars(int level, String gameType) => '${gameType}_stars_level_$level';

  static Future<int> getMaxLevelUnlocked({String gameType = 'memory'}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyMaxLevel(gameType)) ?? 1;
  }

  static Future<void> unlockLevel(int level, {String gameType = 'memory'}) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_keyMaxLevel(gameType)) ?? 1;
    if (level > current) {
      await prefs.setInt(_keyMaxLevel(gameType), level);
    }
  }

  static Future<int> getStars(int level, {String gameType = 'memory'}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyStars(level, gameType)) ?? 0;
  }

  static Future<void> saveStars(int level, int stars, {String gameType = 'memory'}) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_keyStars(level, gameType)) ?? 0;
    if (stars > current) {
      await prefs.setInt(_keyStars(level, gameType), stars);
    }
  }

  static Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
