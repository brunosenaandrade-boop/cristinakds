import 'dart:math';
import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../config/app_sizes.dart';
import '../config/hangman_config.dart';
import '../models/game_state.dart';
import '../widgets/hangman_drawing.dart';
import '../widgets/victory_dialog.dart';

class HangmanScreen extends StatefulWidget {
  final int levelIndex;

  const HangmanScreen({super.key, required this.levelIndex});

  @override
  State<HangmanScreen> createState() => _HangmanScreenState();
}

class _HangmanScreenState extends State<HangmanScreen> {
  late HangmanLevelData _levelData;
  late List<HangmanWord> _sessionWords; // Palavras sorteadas para esta partida
  late HangmanWord _currentWord;
  int _wordIndex = 0;
  int _errors = 0;
  int _totalErrors = 0;
  int _wordsCompleted = 0;
  final Set<String> _guessedLetters = {};
  bool _roundOver = false;

  static const _alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZÇÃÕÉÊÁÀÂÍÓÔÚ';

  @override
  void initState() {
    super.initState();
    _levelData = HangmanConfig.levels[widget.levelIndex];
    _pickSessionWords();
    _loadWord();
  }

  /// Sorteia 5 palavras únicas do banco e embaralha UMA vez
  void _pickSessionWords() {
    final all = List<HangmanWord>.from(_levelData.words);
    all.shuffle(Random());
    _sessionWords = all.take(HangmanConfig.wordsPerLevel).toList();
  }

  void _loadWord() {
    _currentWord = _sessionWords[_wordIndex];
    _errors = 0;
    _guessedLetters.clear();
    _roundOver = false;
  }

  String get _displayWord {
    return _currentWord.word.toUpperCase().split('').map((letter) {
      if (letter == ' ') return '  ';
      if (_guessedLetters.contains(letter)) return letter;
      return '_';
    }).join(' ');
  }

  bool get _wordComplete {
    return _currentWord.word.toUpperCase().split('').every(
          (letter) => letter == ' ' || _guessedLetters.contains(letter),
        );
  }

  void _onLetterTap(String letter) {
    if (_roundOver) return;
    if (_guessedLetters.contains(letter)) return;

    setState(() {
      _guessedLetters.add(letter);

      if (!_currentWord.word.toUpperCase().contains(letter)) {
        _errors++;
        _totalErrors++;

        if (_errors >= _levelData.maxErrors) {
          _roundOver = true;
          // Revelar palavra e avançar após delay
          Future.delayed(const Duration(seconds: 2), () {
            if (!mounted) return;
            _nextWordOrFinish();
          });
        }
      } else {
        if (_wordComplete) {
          _roundOver = true;
          _wordsCompleted++;
          Future.delayed(const Duration(milliseconds: 800), () {
            if (!mounted) return;
            _nextWordOrFinish();
          });
        }
      }
    });
  }

  void _nextWordOrFinish() {
    _wordIndex++;
    if (_wordIndex >= _sessionWords.length) {
      _onVictory();
    } else {
      setState(() {
        _loadWord();
      });
    }
  }

  int _calculateStars() {
    final avgErrors = _totalErrors / _sessionWords.length;
    if (avgErrors <= _levelData.threeStarErrors) return 3;
    if (avgErrors <= _levelData.twoStarErrors) return 2;
    return 1;
  }

  void _onVictory() async {
    final stars = _calculateStars();
    await GameProgress.saveStars(_levelData.level, stars, gameType: 'hangman');
    if (_levelData.level < 10) {
      await GameProgress.unlockLevel(_levelData.level + 1, gameType: 'hangman');
    }

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => VictoryDialog(
        stars: stars,
        moves: _totalErrors,
        time: '$_wordsCompleted/${_sessionWords.length}',
        levelName: _levelData.name,
        hasNextLevel: _levelData.level < 10,
        movesLabel: 'Erros',
        onReplay: () {
          Navigator.pop(context);
          _resetGame();
        },
        onNextLevel: () {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => HangmanScreen(levelIndex: widget.levelIndex + 1),
              transitionsBuilder: (c, animation, a2, child) => FadeTransition(opacity: animation, child: child),
            ),
          );
        },
        onMenu: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _resetGame() {
    setState(() {
      _wordIndex = 0;
      _totalErrors = 0;
      _wordsCompleted = 0;
      _pickSessionWords(); // Re-sorteia palavras novas
      _loadWord();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.gameGradientTop, AppTheme.gameGradientBottom],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium, vertical: AppSizes.paddingSmall),
                child: Row(
                  children: [
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded, color: Colors.white)),
                    Expanded(
                      child: Text(
                        'Nível ${_levelData.level} - ${_levelData.name}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: AppTheme.gameLevelTitleFontSize, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    IconButton(onPressed: _resetGame, icon: const Icon(Icons.refresh_rounded, color: Colors.white)),
                  ],
                ),
              ),

              // Progresso: palavra X de Y
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoChip(Icons.article_rounded, 'Palavra ${_wordIndex + 1}/${_sessionWords.length}'),
                    _buildInfoChip(Icons.close_rounded, 'Erros: $_errors/${_levelData.maxErrors}'),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Desenho do boneco
              HangmanDrawing(errors: _errors, maxErrors: _levelData.maxErrors),

              const SizedBox(height: 12),

              // Dica
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.hangmanHintBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lightbulb_outline_rounded, color: AppTheme.accentColor, size: 20),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        _currentWord.hint,
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Palavra com underscores
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _displayWord,
                    style: const TextStyle(
                      fontSize: AppTheme.hangmanWordFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ),

              // Status (acertou / errou)
              if (_roundOver)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _wordComplete ? 'Acertou!' : 'Era: ${_currentWord.word.toUpperCase()}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _wordComplete ? AppTheme.successColor : AppTheme.secondaryColor,
                    ),
                  ),
                ),

              const Spacer(),

              // Teclado de letras
              _buildKeyboard(),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    final letters = _alphabet.split('');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 5,
        runSpacing: 5,
        children: letters.map((letter) {
          final isGuessed = _guessedLetters.contains(letter);
          final isCorrect = isGuessed && _currentWord.word.toUpperCase().contains(letter);
          final isWrong = isGuessed && !_currentWord.word.toUpperCase().contains(letter);

          Color bgColor;
          if (isCorrect) {
            bgColor = AppTheme.hangmanCorrectLetterBg;
          } else if (isWrong) {
            bgColor = AppTheme.hangmanWrongLetterBg;
          } else {
            bgColor = AppTheme.hangmanKeyBg;
          }

          return SizedBox(
            width: 38,
            height: 42,
            child: Material(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: isGuessed || _roundOver ? null : () => _onLetterTap(letter),
                borderRadius: BorderRadius.circular(8),
                child: Center(
                  child: Text(
                    letter,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isGuessed ? Colors.white54 : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppTheme.accentColor, size: 18),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}
