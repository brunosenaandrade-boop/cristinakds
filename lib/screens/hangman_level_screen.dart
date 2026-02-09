import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../config/app_sizes.dart';
import '../config/hangman_config.dart';
import '../models/game_state.dart';
import 'hangman_screen.dart';

class HangmanLevelScreen extends StatefulWidget {
  const HangmanLevelScreen({super.key});

  @override
  State<HangmanLevelScreen> createState() => _HangmanLevelScreenState();
}

class _HangmanLevelScreenState extends State<HangmanLevelScreen> {
  int _maxLevel = 1;
  final Map<int, int> _stars = {};

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final maxLevel = await GameProgress.getMaxLevelUnlocked(gameType: 'hangman');
    final stars = <int, int>{};
    for (int i = 1; i <= 10; i++) {
      stars[i] = await GameProgress.getStars(i, gameType: 'hangman');
    }
    if (mounted) {
      setState(() {
        _maxLevel = maxLevel;
        _stars.addAll(stars);
      });
    }
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
              AppTheme.levelSelectGradientTop,
              AppTheme.levelSelectGradientMiddle,
              AppTheme.levelSelectGradientBottom,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 28),
                    ),
                    const Expanded(
                      child: Text(
                        'Jogo da Forca',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppTheme.levelSelectTitleFontSize,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.levelSelectTitleColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.levelGridPadding),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: AppSizes.levelGridCrossAxisCount,
                      mainAxisSpacing: AppSizes.levelGridSpacing,
                      crossAxisSpacing: AppSizes.levelGridSpacing,
                      childAspectRatio: AppSizes.levelGridChildAspectRatio,
                    ),
                    itemCount: HangmanConfig.levels.length,
                    itemBuilder: (context, index) {
                      final level = HangmanConfig.levels[index];
                      final isUnlocked = level.level <= _maxLevel;
                      final starCount = _stars[level.level] ?? 0;
                      return _buildLevelCard(level, isUnlocked, starCount);
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

  Widget _buildLevelCard(HangmanLevelData level, bool isUnlocked, int starCount) {
    return GestureDetector(
      onTap: isUnlocked
          ? () async {
              await Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => HangmanScreen(levelIndex: level.level - 1),
                  transitionsBuilder: (c, animation, a2, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
                      child: child,
                    );
                  },
                ),
              );
              _loadProgress();
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isUnlocked ? AppTheme.hangmanLevelCardColor : AppTheme.levelCardLockedColor,
          borderRadius: BorderRadius.circular(AppTheme.levelCardBorderRadius),
          boxShadow: isUnlocked
              ? [BoxShadow(color: AppTheme.hangmanLevelCardColor.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4))]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isUnlocked) ...[
              Text('${level.level}', style: const TextStyle(fontSize: AppTheme.levelCardNumberFontSize, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              Text(level.name, style: const TextStyle(fontSize: AppTheme.levelCardLabelFontSize, color: Colors.white70)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) => Icon(i < starCount ? Icons.star_rounded : Icons.star_outline_rounded, color: AppTheme.levelCardStarColor, size: AppTheme.levelCardStarSize)),
              ),
            ] else ...[
              const Icon(Icons.lock_rounded, color: Color(0xFF555555), size: 36),
              const SizedBox(height: 4),
              Text('Nível ${level.level}', style: const TextStyle(fontSize: AppTheme.levelCardLabelFontSize, color: Color(0xFF555555))),
            ],
          ],
        ),
      ),
    );
  }
}
