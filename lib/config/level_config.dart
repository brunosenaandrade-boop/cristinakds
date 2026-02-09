// ============================================================
// CONFIGURAÇÃO DOS 10 NÍVEIS - CristinaKids
// ============================================================
// Quer mudar quantidade de cartas, colunas ou emojis?
// Mude AQUI!
// ============================================================

class LevelData {
  final int level;
  final String name;
  final int rows;
  final int cols;
  final int pairs;
  final List<String> emojis;
  final int threeStarMoves; // Máximo de jogadas pra 3 estrelas
  final int twoStarMoves; // Máximo de jogadas pra 2 estrelas

  const LevelData({
    required this.level,
    required this.name,
    required this.rows,
    required this.cols,
    required this.pairs,
    required this.emojis,
    required this.threeStarMoves,
    required this.twoStarMoves,
  });
}

class LevelConfig {
  // ===== EMOJIS POR CATEGORIA =====
  static const animais = ['🐶', '🐱', '🐭', '🐹', '🐰', '🦊', '🐻', '🐼', '🐨', '🐯', '🦁', '🐮', '🐷', '🐸', '🐵', '🐔', '🐧', '🐦', '🦋', '🐢', '🐙'];
  static const frutas = ['🍎', '🍐', '🍊', '🍋', '🍌', '🍉', '🍇', '🍓', '🫐', '🍑', '🍒', '🥝', '🍍', '🥭', '🍈', '🥥', '🍅', '🥑', '🌽', '🥕', '🥦'];
  static const esportes = ['⚽', '🏀', '🏈', '⚾', '🎾', '🏐', '🏓', '🎯', '🏆', '🥇', '🎳', '🏸', '🥊', '⛷️', '🏄', '🚴', '🏊', '⛹️', '🤸', '🎮', '🎲'];
  static const natureza = ['🌸', '🌺', '🌻', '🌹', '🌷', '🌵', '🍀', '🌈', '⭐', '🌙', '☀️', '❄️', '🔥', '💧', '🌊', '🍂', '🌴', '🌾', '💐', '🪷', '🌿'];

  // ===== CONFIGURAÇÃO DOS 10 NÍVEIS =====
  static final List<LevelData> levels = [
    // NÍVEL 1 - Muito Fácil (2x2 = 4 cartas, 2 pares)
    LevelData(
      level: 1,
      name: 'Bebê',
      rows: 2,
      cols: 2,
      pairs: 2,
      emojis: animais.sublist(0, 2),
      threeStarMoves: 4,
      twoStarMoves: 6,
    ),

    // NÍVEL 2 - Fácil (2x3 = 6 cartas, 3 pares)
    LevelData(
      level: 2,
      name: 'Iniciante',
      rows: 2,
      cols: 3,
      pairs: 3,
      emojis: frutas.sublist(0, 3),
      threeStarMoves: 6,
      twoStarMoves: 10,
    ),

    // NÍVEL 3 - Fácil+ (2x4 = 8 cartas, 4 pares)
    LevelData(
      level: 3,
      name: 'Curioso',
      rows: 2,
      cols: 4,
      pairs: 4,
      emojis: animais.sublist(2, 6),
      threeStarMoves: 8,
      twoStarMoves: 14,
    ),

    // NÍVEL 4 - Médio (3x4 = 12 cartas, 6 pares)
    LevelData(
      level: 4,
      name: 'Esperto',
      rows: 3,
      cols: 4,
      pairs: 6,
      emojis: esportes.sublist(0, 6),
      threeStarMoves: 12,
      twoStarMoves: 20,
    ),

    // NÍVEL 5 - Médio+ (4x4 = 16 cartas, 8 pares)
    LevelData(
      level: 5,
      name: 'Inteligente',
      rows: 4,
      cols: 4,
      pairs: 8,
      emojis: natureza.sublist(0, 8),
      threeStarMoves: 16,
      twoStarMoves: 26,
    ),

    // NÍVEL 6 - Difícil (4x5 = 20 cartas, 10 pares)
    LevelData(
      level: 6,
      name: 'Desafiador',
      rows: 4,
      cols: 5,
      pairs: 10,
      emojis: animais.sublist(0, 10),
      threeStarMoves: 20,
      twoStarMoves: 34,
    ),

    // NÍVEL 7 - Difícil+ (4x6 = 24 cartas, 12 pares)
    LevelData(
      level: 7,
      name: 'Ninja',
      rows: 4,
      cols: 6,
      pairs: 12,
      emojis: frutas.sublist(0, 12),
      threeStarMoves: 24,
      twoStarMoves: 40,
    ),

    // NÍVEL 8 - Muito Difícil (5x6 = 30 cartas, 15 pares)
    LevelData(
      level: 8,
      name: 'Gênio',
      rows: 5,
      cols: 6,
      pairs: 15,
      emojis: esportes.sublist(0, 15),
      threeStarMoves: 30,
      twoStarMoves: 50,
    ),

    // NÍVEL 9 - Expert (6x6 = 36 cartas, 18 pares)
    LevelData(
      level: 9,
      name: 'Expert',
      rows: 6,
      cols: 6,
      pairs: 18,
      emojis: [...animais.sublist(0, 9), ...natureza.sublist(0, 9)],
      threeStarMoves: 36,
      twoStarMoves: 60,
    ),

    // NÍVEL 10 - Mestre (6x7 = 42 cartas, 21 pares)
    LevelData(
      level: 10,
      name: 'Mestre',
      rows: 6,
      cols: 7,
      pairs: 21,
      emojis: [...animais.sublist(0, 7), ...frutas.sublist(0, 7), ...esportes.sublist(0, 7)],
      threeStarMoves: 42,
      twoStarMoves: 70,
    ),
  ];
}
