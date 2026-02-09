import 'dart:async';
import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../config/app_sizes.dart';
import '../config/word_search_config.dart';
import '../models/word_search_logic.dart';
import '../models/game_state.dart';
import '../widgets/word_grid.dart';
import '../widgets/word_list_widget.dart';
import '../widgets/victory_dialog.dart';

class WordSearchScreen extends StatefulWidget {
  final int levelIndex;

  const WordSearchScreen({super.key, required this.levelIndex});

  @override
  State<WordSearchScreen> createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchScreen> {
  late WordSearchLevelData _levelData;
  late WordSearchGrid _grid;
  int _seconds = 0;
  int _wordsFound = 0;
  Timer? _timer;
  final Set<String> _foundPositions = {};
  final Map<String, Color> _positionColorMap = {};
  final List<Color> _wordColors = [];

  // Cores para destacar cada palavra encontrada
  static const _highlightColors = [
    Color(0xFFFF6584),
    Color(0xFF00C851),
    Color(0xFF6C63FF),
    Color(0xFFFFD93D),
    Color(0xFF00BCD4),
    Color(0xFFFF9800),
    Color(0xFFE91E63),
    Color(0xFF8BC34A),
    Color(0xFF9C27B0),
    Color(0xFF3F51B5),
    Color(0xFFFF5722),
    Color(0xFF009688),
  ];

  @override
  void initState() {
    super.initState();
    _levelData = WordSearchConfig.levels[widget.levelIndex];
    _grid = WordSearchGrid(size: _levelData.gridSize);
    _grid.generate(_levelData);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _seconds++);
    });
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _onSelectionComplete(List<List<int>> selectedPositions) {
    final match = _grid.checkSelection(selectedPositions);

    if (match != null && !match.found) {
      final colorIndex = _wordsFound % _highlightColors.length;
      final color = _highlightColors[colorIndex];

      setState(() {
        match.found = true;
        _wordsFound++;
        _wordColors.add(color);

        for (final pos in match.positions) {
          final key = '${pos[0]},${pos[1]}';
          _foundPositions.add(key);
          _positionColorMap[key] = color;
        }
      });

      if (_grid.allFound) {
        _timer?.cancel();
        _onVictory();
      }
    }
  }

  int _calculateStars() {
    if (_seconds <= _levelData.threeStarSeconds) return 3;
    if (_seconds <= _levelData.twoStarSeconds) return 2;
    return 1;
  }

  void _onVictory() async {
    final stars = _calculateStars();

    await GameProgress.saveStars(_levelData.level, stars, gameType: 'ws');
    if (_levelData.level < 10) {
      await GameProgress.unlockLevel(_levelData.level + 1, gameType: 'ws');
    }

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => VictoryDialog(
        stars: stars,
        moves: _wordsFound,
        time: _formatTime(_seconds),
        levelName: _levelData.name,
        hasNextLevel: _levelData.level < 10,
        movesLabel: 'Palavras',
        onReplay: () {
          Navigator.pop(context);
          _resetGame();
        },
        onNextLevel: () {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => WordSearchScreen(levelIndex: widget.levelIndex + 1),
              transitionsBuilder: (c, animation, a2, child) {
                return FadeTransition(opacity: animation, child: child);
              },
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
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _wordsFound = 0;
      _foundPositions.clear();
      _positionColorMap.clear();
      _wordColors.clear();
      _grid = WordSearchGrid(size: _levelData.gridSize);
      _grid.generate(_levelData);
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

              const SizedBox(height: 8),

              // Info: tempo + encontradas
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoChip(Icons.timer_rounded, _formatTime(_seconds)),
                    _buildInfoChip(Icons.search_rounded, '$_wordsFound / ${_levelData.words.length}'),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Lista de palavras para encontrar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: WordListWidget(
                  words: _grid.placedWords,
                  wordColors: _wordColors,
                ),
              ),

              const SizedBox(height: 12),

              // Grid de letras
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.gameGridPadding),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: WordGrid(
                        grid: _grid.grid,
                        gridSize: _levelData.gridSize,
                        foundPositions: _foundPositions,
                        foundColors: _wordColors,
                        positionColorMap: _positionColorMap,
                        onSelectionComplete: _onSelectionComplete,
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
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          ),
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
          IconButton(
            onPressed: _resetGame,
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
          ),
        ],
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
          Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }
}
