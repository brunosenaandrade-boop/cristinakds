import 'dart:async';
import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../config/app_sizes.dart';
import '../config/level_config.dart';
import '../models/card_model.dart';
import '../models/game_state.dart';
import '../widgets/game_card.dart';
import '../widgets/victory_dialog.dart';

class GameScreen extends StatefulWidget {
  final int levelIndex;

  const GameScreen({super.key, required this.levelIndex});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late LevelData _levelData;
  late List<CardModel> _cards;
  int _moves = 0;
  int _matchedPairs = 0;
  int _seconds = 0;
  Timer? _timer;
  CardModel? _firstCard;
  CardModel? _secondCard;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    _levelData = LevelConfig.levels[widget.levelIndex];
    _initCards();
    _startTimer();
  }

  void _initCards() {
    _cards = [];
    final emojis = List<String>.from(_levelData.emojis);

    for (int i = 0; i < _levelData.pairs; i++) {
      final emoji = emojis[i];
      _cards.add(CardModel(id: i * 2, emoji: emoji, pairId: i));
      _cards.add(CardModel(id: i * 2 + 1, emoji: emoji, pairId: i));
    }

    _cards.shuffle();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() => _seconds++);
      }
    });
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _onCardTap(CardModel card) {
    if (_isChecking) return;
    if (card.isFaceUp || card.isMatched) return;

    setState(() {
      card.isFaceUp = true;
    });

    if (_firstCard == null) {
      _firstCard = card;
    } else {
      _secondCard = card;
      _moves++;
      _isChecking = true;
      _checkMatch();
    }
  }

  void _checkMatch() {
    if (_firstCard!.pairId == _secondCard!.pairId) {
      // Par encontrado!
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        setState(() {
          _firstCard!.isMatched = true;
          _secondCard!.isMatched = true;
          _matchedPairs++;
          _firstCard = null;
          _secondCard = null;
          _isChecking = false;
        });

        // Verificar vitória
        if (_matchedPairs == _levelData.pairs) {
          _timer?.cancel();
          _onVictory();
        }
      });
    } else {
      // Não é par - vira de volta
      Future.delayed(AppTheme.cardMatchDelay, () {
        if (!mounted) return;
        setState(() {
          _firstCard!.isFaceUp = false;
          _secondCard!.isFaceUp = false;
          _firstCard = null;
          _secondCard = null;
          _isChecking = false;
        });
      });
    }
  }

  int _calculateStars() {
    if (_moves <= _levelData.threeStarMoves) return 3;
    if (_moves <= _levelData.twoStarMoves) return 2;
    return 1;
  }

  void _onVictory() async {
    final stars = _calculateStars();

    // Salvar progresso
    await GameProgress.saveStars(_levelData.level, stars);
    if (_levelData.level < 10) {
      await GameProgress.unlockLevel(_levelData.level + 1);
    }

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => VictoryDialog(
        stars: stars,
        moves: _moves,
        time: _formatTime(_seconds),
        levelName: _levelData.name,
        hasNextLevel: _levelData.level < 10,
        onReplay: () {
          Navigator.pop(context); // Fecha dialog
          _resetGame();
        },
        onNextLevel: () {
          Navigator.pop(context); // Fecha dialog
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => GameScreen(levelIndex: widget.levelIndex + 1),
              transitionsBuilder: (c, animation, a2, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        },
        onMenu: () {
          Navigator.pop(context); // Fecha dialog
          Navigator.pop(context); // Volta pro menu
        },
      ),
    );
  }

  void _resetGame() {
    _timer?.cancel();
    setState(() {
      _moves = 0;
      _matchedPairs = 0;
      _seconds = 0;
      _firstCard = null;
      _secondCard = null;
      _isChecking = false;
      _initCards();
    });
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
            colors: [
              AppTheme.gameGradientTop,
              AppTheme.gameGradientBottom,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Barra superior
              _buildTopBar(),

              // Grid de cartas
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.gameGridPadding),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: _levelData.cols / _levelData.rows,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _levelData.cols,
                          mainAxisSpacing: AppSizes.gameGridSpacing,
                          crossAxisSpacing: AppSizes.gameGridSpacing,
                        ),
                        itemCount: _cards.length,
                        itemBuilder: (context, index) {
                          final card = _cards[index];
                          return GameCard(
                            card: card,
                            onTap: () => _onCardTap(card),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: AppSizes.paddingSmall,
      ),
      child: Row(
        children: [
          // Botão voltar
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          ),

          // Nível
          Expanded(
            child: Text(
              'Nível ${_levelData.level} - ${_levelData.name}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: AppTheme.gameLevelTitleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // Botão resetar
          IconButton(
            onPressed: _resetGame,
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
