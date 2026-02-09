import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../config/app_sizes.dart';
import '../config/quiz_config.dart';
import '../models/game_state.dart';
import '../widgets/victory_dialog.dart';

class QuizScreen extends StatefulWidget {
  final int levelIndex;

  const QuizScreen({super.key, required this.levelIndex});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late QuizLevelData _levelData;
  int _questionIndex = 0;
  int _correctCount = 0;
  int? _selectedOption;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _levelData = QuizConfig.levels[widget.levelIndex];
  }

  QuizQuestion get _currentQuestion => _levelData.questions[_questionIndex];

  void _onOptionTap(int index) {
    if (_answered) return;

    setState(() {
      _selectedOption = index;
      _answered = true;

      if (index == _currentQuestion.correctIndex) {
        _correctCount++;
      }
    });

    // Avançar após delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;

      if (_questionIndex + 1 >= _levelData.questions.length) {
        _onFinish();
      } else {
        setState(() {
          _questionIndex++;
          _selectedOption = null;
          _answered = false;
        });
      }
    });
  }

  int _calculateStars() {
    if (_correctCount >= _levelData.threeStarCorrect) return 3;
    if (_correctCount >= _levelData.twoStarCorrect) return 2;
    return 1;
  }

  void _onFinish() async {
    final stars = _calculateStars();

    await GameProgress.saveStars(_levelData.level, stars, gameType: 'quiz');
    if (_levelData.level < 10) {
      await GameProgress.unlockLevel(_levelData.level + 1, gameType: 'quiz');
    }

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => VictoryDialog(
        stars: stars,
        moves: _correctCount,
        time: '${_levelData.questions.length} perguntas',
        levelName: _levelData.name,
        hasNextLevel: _levelData.level < 10,
        movesLabel: 'Acertos',
        onReplay: () {
          Navigator.pop(context);
          _resetGame();
        },
        onNextLevel: () {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => QuizScreen(levelIndex: widget.levelIndex + 1),
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
      _questionIndex = 0;
      _correctCount = 0;
      _selectedOption = null;
      _answered = false;
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
                        _levelData.category,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: AppTheme.gameLevelTitleFontSize, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // Progresso
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoChip(Icons.help_outline_rounded, '${_questionIndex + 1}/${_levelData.questions.length}'),
                    _buildInfoChip(Icons.check_circle_outline_rounded, '$_correctCount acertos'),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Barra de progresso
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: (_questionIndex + 1) / _levelData.questions.length,
                    minHeight: 8,
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Pergunta
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                  ),
                  child: Text(
                    _currentQuestion.question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: AppTheme.quizQuestionFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Opções
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView.separated(
                    itemCount: _currentQuestion.options.length,
                    separatorBuilder: (_, i) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildOption(index);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(int index) {
    final isSelected = _selectedOption == index;
    final isCorrect = index == _currentQuestion.correctIndex;
    final showResult = _answered;

    Color bgColor;
    Color borderColor;
    if (showResult && isCorrect) {
      bgColor = AppTheme.quizCorrectBg;
      borderColor = AppTheme.quizCorrectBorder;
    } else if (showResult && isSelected && !isCorrect) {
      bgColor = AppTheme.quizWrongBg;
      borderColor = AppTheme.quizWrongBorder;
    } else if (isSelected) {
      bgColor = AppTheme.primaryColor.withValues(alpha: 0.3);
      borderColor = AppTheme.primaryColor;
    } else {
      bgColor = Colors.white.withValues(alpha: 0.06);
      borderColor = Colors.white.withValues(alpha: 0.15);
    }

    final labels = ['A', 'B', 'C', 'D'];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _answered ? null : () => _onOptionTap(index),
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Row(
            children: [
              // Letra da opção (A, B, C, D)
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: showResult && isCorrect
                      ? AppTheme.successColor
                      : showResult && isSelected && !isCorrect
                          ? AppTheme.secondaryColor
                          : Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    labels[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  _currentQuestion.options[index],
                  style: const TextStyle(
                    fontSize: AppTheme.quizOptionFontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              if (showResult && isCorrect)
                const Icon(Icons.check_circle_rounded, color: AppTheme.successColor, size: 26),
              if (showResult && isSelected && !isCorrect)
                const Icon(Icons.cancel_rounded, color: AppTheme.secondaryColor, size: 26),
            ],
          ),
        ),
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
