import 'dart:math';
import '../config/word_search_config.dart';

class PlacedWord {
  final String word;
  final int startRow;
  final int startCol;
  final int dRow;
  final int dCol;
  final List<List<int>> positions; // [[row, col], ...]
  bool found;

  PlacedWord({
    required this.word,
    required this.startRow,
    required this.startCol,
    required this.dRow,
    required this.dCol,
    required this.positions,
    this.found = false,
  });
}

class WordSearchGrid {
  final int size;
  late List<List<String>> grid;
  late List<PlacedWord> placedWords;
  final Random _random = Random();

  // Letras usadas para preencher (com acentos comuns do PT-BR)
  static const _fillLetters = 'ABCDEFGHIJLMNOPQRSTUVXZÃÕÉÊÇÁÀÂÍÓÔÚ';

  WordSearchGrid({required this.size}) {
    grid = List.generate(size, (_) => List.generate(size, (_) => ''));
    placedWords = [];
  }

  /// Gera o grid completo com palavras posicionadas
  bool generate(WordSearchLevelData levelData) {
    // Limpar grid
    grid = List.generate(size, (_) => List.generate(size, (_) => ''));
    placedWords = [];

    // Tentar posicionar cada palavra
    final words = List<String>.from(levelData.words);
    words.sort((a, b) => b.length.compareTo(a.length)); // Maiores primeiro

    for (final word in words) {
      final upperWord = word.toUpperCase();
      bool placed = false;

      // Tentar até 100 vezes posicionar a palavra
      for (int attempt = 0; attempt < 100; attempt++) {
        final direction = _getRandomDirection(levelData);
        final reverse = levelData.allowReverse && _random.nextBool();

        final wordToPlace = reverse ? upperWord.split('').reversed.join() : upperWord;

        int dRow = 0, dCol = 0;
        switch (direction) {
          case WordDirection.horizontal:
            dRow = 0;
            dCol = 1;
            break;
          case WordDirection.vertical:
            dRow = 1;
            dCol = 0;
            break;
          case WordDirection.diagonalDown:
            dRow = 1;
            dCol = 1;
            break;
          case WordDirection.diagonalUp:
            dRow = -1;
            dCol = 1;
            break;
        }

        final maxRow = direction == WordDirection.diagonalUp
            ? size - 1
            : size - (dRow * (wordToPlace.length - 1)) - 1;
        final minRow = direction == WordDirection.diagonalUp
            ? wordToPlace.length - 1
            : 0;
        final maxCol = size - (dCol * (wordToPlace.length - 1)) - 1;

        if (maxRow < minRow || maxCol < 0) continue;

        final startRow = minRow + _random.nextInt(maxRow - minRow + 1);
        final startCol = _random.nextInt(maxCol + 1);

        if (_canPlace(wordToPlace, startRow, startCol, dRow, dCol)) {
          final positions = _placeWord(wordToPlace, startRow, startCol, dRow, dCol);
          placedWords.add(PlacedWord(
            word: word, // Manter a palavra original com acento
            startRow: startRow,
            startCol: startCol,
            dRow: dRow,
            dCol: dCol,
            positions: positions,
          ));
          placed = true;
          break;
        }
      }

      if (!placed) {
        // Falhou em posicionar: regenerar tudo
        return generate(levelData);
      }
    }

    // Preencher espaços vazios com letras aleatórias
    _fillEmpty();
    return true;
  }

  WordDirection _getRandomDirection(WordSearchLevelData levelData) {
    final dirs = levelData.allowedDirections;
    return dirs[_random.nextInt(dirs.length)];
  }

  bool _canPlace(String word, int row, int col, int dRow, int dCol) {
    for (int i = 0; i < word.length; i++) {
      final r = row + (i * dRow);
      final c = col + (i * dCol);

      if (r < 0 || r >= size || c < 0 || c >= size) return false;

      if (grid[r][c] != '' && grid[r][c] != word[i]) return false;
    }
    return true;
  }

  List<List<int>> _placeWord(String word, int row, int col, int dRow, int dCol) {
    final positions = <List<int>>[];
    for (int i = 0; i < word.length; i++) {
      final r = row + (i * dRow);
      final c = col + (i * dCol);
      grid[r][c] = word[i];
      positions.add([r, c]);
    }
    return positions;
  }

  void _fillEmpty() {
    for (int r = 0; r < size; r++) {
      for (int c = 0; c < size; c++) {
        if (grid[r][c] == '') {
          grid[r][c] = _fillLetters[_random.nextInt(_fillLetters.length)];
        }
      }
    }
  }

  /// Verifica se uma seleção de posições corresponde a uma palavra
  PlacedWord? checkSelection(List<List<int>> selectedPositions) {
    for (final pw in placedWords) {
      if (pw.found) continue;

      if (pw.positions.length != selectedPositions.length) continue;

      // Verificar na ordem normal
      bool matchForward = true;
      for (int i = 0; i < pw.positions.length; i++) {
        if (pw.positions[i][0] != selectedPositions[i][0] ||
            pw.positions[i][1] != selectedPositions[i][1]) {
          matchForward = false;
          break;
        }
      }

      // Verificar na ordem reversa
      bool matchReverse = true;
      for (int i = 0; i < pw.positions.length; i++) {
        final ri = pw.positions.length - 1 - i;
        if (pw.positions[ri][0] != selectedPositions[i][0] ||
            pw.positions[ri][1] != selectedPositions[i][1]) {
          matchReverse = false;
          break;
        }
      }

      if (matchForward || matchReverse) {
        return pw;
      }
    }
    return null;
  }

  bool get allFound => placedWords.every((w) => w.found);
}
