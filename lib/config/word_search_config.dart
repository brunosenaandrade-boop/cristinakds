// ============================================================
// CONFIGURAÇÃO DOS 10 NÍVEIS DO CAÇA-PALAVRAS - CristinaKids
// ============================================================
// Quer mudar palavras, tamanho do grid ou dificuldade?
// Mude AQUI!
// ============================================================

enum WordDirection { horizontal, vertical, diagonalDown, diagonalUp }

class WordSearchLevelData {
  final int level;
  final String name;
  final int gridSize;
  final List<String> words;
  final List<WordDirection> allowedDirections;
  final bool allowReverse;
  final int threeStarSeconds; // Tempo max pra 3 estrelas
  final int twoStarSeconds; // Tempo max pra 2 estrelas

  const WordSearchLevelData({
    required this.level,
    required this.name,
    required this.gridSize,
    required this.words,
    required this.allowedDirections,
    this.allowReverse = false,
    required this.threeStarSeconds,
    required this.twoStarSeconds,
  });
}

class WordSearchConfig {
  // ===== BANCO DE PALAVRAS POR CATEGORIA =====

  // ANIMAIS
  static const animaisCurtos = ['GATO', 'CÃO', 'BOI', 'AVE', 'RÃ'];
  static const animaisMedios = ['PATO', 'URSO', 'LOBO', 'RATO', 'LEÃO', 'SAPO', 'PEIXE', 'TIGRE', 'COBRA'];
  static const animaisLongos = ['CAVALO', 'COELHO', 'MACACO', 'GIRAFA', 'BALEIA', 'RAPOSA', 'ELEFANTE', 'TARTARUGA'];

  // FRUTAS
  static const frutasCurtos = ['UVA', 'KIWI', 'MAÇÃ'];
  static const frutasMedios = ['PERA', 'LIMÃO', 'MANGA', 'COCO', 'AMORA', 'MAMÃO', 'GOIABA', 'MORANGO'];
  static const frutasLongos = ['MELANCIA', 'ABACAXI', 'LARANJA', 'BANANA', 'CEREJA', 'PESSEGO'];

  // NATUREZA
  static const naturezaCurtos = ['SOL', 'LUA', 'MAR', 'RIO', 'CÉU'];
  static const naturezaMedios = ['FLOR', 'NEVE', 'VENTO', 'TERRA', 'CHUVA', 'NUVEM', 'FOLHA', 'PEDRA'];
  static const naturezaLongos = ['ESTRELA', 'MONTANHA', 'FLORESTA', 'OCEANO', 'VULCÃO', 'CACHOEIRA'];

  // CORES
  static const coresMedios = ['AZUL', 'ROSA', 'ROXO', 'VERDE', 'PRETO', 'CINZA', 'BRANCO'];

  // CORPO
  static const corpoMedios = ['MÃO', 'PÉ', 'OLHO', 'NARIZ', 'BOCA', 'DENTE', 'BRAÇO', 'PERNA', 'CABEÇA'];

  // ===== CONFIGURAÇÃO DOS 10 NÍVEIS =====
  static final List<WordSearchLevelData> levels = [
    // NÍVEL 1 - Muito Fácil (6x6, 3 palavras, só horizontal)
    const WordSearchLevelData(
      level: 1,
      name: 'Bebê',
      gridSize: 6,
      words: ['GATO', 'CÃO', 'AVE'],
      allowedDirections: [WordDirection.horizontal],
      threeStarSeconds: 30,
      twoStarSeconds: 60,
    ),

    // NÍVEL 2 - Fácil (7x7, 4 palavras, horizontal + vertical)
    const WordSearchLevelData(
      level: 2,
      name: 'Iniciante',
      gridSize: 7,
      words: ['UVA', 'PERA', 'MAÇÃ', 'KIWI'],
      allowedDirections: [WordDirection.horizontal, WordDirection.vertical],
      threeStarSeconds: 45,
      twoStarSeconds: 90,
    ),

    // NÍVEL 3 - Fácil+ (8x8, 5 palavras, horizontal + vertical)
    const WordSearchLevelData(
      level: 3,
      name: 'Curioso',
      gridSize: 8,
      words: ['SOL', 'LUA', 'MAR', 'FLOR', 'NEVE'],
      allowedDirections: [WordDirection.horizontal, WordDirection.vertical],
      threeStarSeconds: 60,
      twoStarSeconds: 120,
    ),

    // NÍVEL 4 - Médio (8x8, 6 palavras, H + V + Diagonal)
    const WordSearchLevelData(
      level: 4,
      name: 'Esperto',
      gridSize: 8,
      words: ['PATO', 'URSO', 'LOBO', 'RATO', 'SAPO', 'LEÃO'],
      allowedDirections: [WordDirection.horizontal, WordDirection.vertical, WordDirection.diagonalDown],
      threeStarSeconds: 75,
      twoStarSeconds: 150,
    ),

    // NÍVEL 5 - Médio+ (9x9, 7 palavras, todas direções)
    const WordSearchLevelData(
      level: 5,
      name: 'Inteligente',
      gridSize: 9,
      words: ['AZUL', 'ROSA', 'ROXO', 'VERDE', 'PRETO', 'CINZA', 'BRANCO'],
      allowedDirections: [WordDirection.horizontal, WordDirection.vertical, WordDirection.diagonalDown, WordDirection.diagonalUp],
      threeStarSeconds: 90,
      twoStarSeconds: 180,
    ),

    // NÍVEL 6 - Difícil (10x10, 8 palavras, todas + reverso)
    const WordSearchLevelData(
      level: 6,
      name: 'Desafiador',
      gridSize: 10,
      words: ['LIMÃO', 'MANGA', 'COCO', 'AMORA', 'MAMÃO', 'GOIABA', 'BANANA', 'CEREJA'],
      allowedDirections: [WordDirection.horizontal, WordDirection.vertical, WordDirection.diagonalDown, WordDirection.diagonalUp],
      allowReverse: true,
      threeStarSeconds: 120,
      twoStarSeconds: 240,
    ),

    // NÍVEL 7 - Difícil+ (10x10, 9 palavras)
    const WordSearchLevelData(
      level: 7,
      name: 'Ninja',
      gridSize: 10,
      words: ['VENTO', 'TERRA', 'CHUVA', 'NUVEM', 'FOLHA', 'PEDRA', 'ESTRELA', 'OCEANO', 'VULCÃO'],
      allowedDirections: [WordDirection.horizontal, WordDirection.vertical, WordDirection.diagonalDown, WordDirection.diagonalUp],
      allowReverse: true,
      threeStarSeconds: 150,
      twoStarSeconds: 300,
    ),

    // NÍVEL 8 - Muito Difícil (11x11, 10 palavras)
    const WordSearchLevelData(
      level: 8,
      name: 'Gênio',
      gridSize: 11,
      words: ['CAVALO', 'COELHO', 'MACACO', 'GIRAFA', 'RAPOSA', 'TIGRE', 'COBRA', 'PEIXE', 'BALEIA', 'ELEFANTE'],
      allowedDirections: [WordDirection.horizontal, WordDirection.vertical, WordDirection.diagonalDown, WordDirection.diagonalUp],
      allowReverse: true,
      threeStarSeconds: 180,
      twoStarSeconds: 360,
    ),

    // NÍVEL 9 - Expert (12x12, 11 palavras)
    const WordSearchLevelData(
      level: 9,
      name: 'Expert',
      gridSize: 12,
      words: ['MELANCIA', 'ABACAXI', 'LARANJA', 'MORANGO', 'PESSEGO', 'MONTANHA', 'FLORESTA', 'CACHOEIRA', 'OLHO', 'NARIZ', 'BOCA'],
      allowedDirections: [WordDirection.horizontal, WordDirection.vertical, WordDirection.diagonalDown, WordDirection.diagonalUp],
      allowReverse: true,
      threeStarSeconds: 210,
      twoStarSeconds: 420,
    ),

    // NÍVEL 10 - Mestre (13x13, 12 palavras)
    const WordSearchLevelData(
      level: 10,
      name: 'Mestre',
      gridSize: 13,
      words: ['TARTARUGA', 'ELEFANTE', 'CACHOEIRA', 'FLORESTA', 'MELANCIA', 'ABACAXI', 'ESTRELA', 'MONTANHA', 'CABEÇA', 'DENTE', 'BRAÇO', 'PERNA'],
      allowedDirections: [WordDirection.horizontal, WordDirection.vertical, WordDirection.diagonalDown, WordDirection.diagonalUp],
      allowReverse: true,
      threeStarSeconds: 240,
      twoStarSeconds: 480,
    ),
  ];
}
