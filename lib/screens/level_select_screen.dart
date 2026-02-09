import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../config/app_sizes.dart';
import '../config/level_config.dart';
import '../models/game_state.dart';
import 'game_screen.dart';

class LevelSelectScreen extends StatefulWidget {
  const LevelSelectScreen({super.key});

  @override
  State<LevelSelectScreen> createState() => _LevelSelectScreenState();
}

class _LevelSelectScreenState extends State<LevelSelectScreen> {
  int _maxLevel = 1;
  final Map<int, int> _stars = {};

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final maxLevel = await GameProgress.getMaxLevelUnlocked();
    final stars = <int, int>{};
    for (int i = 1; i <= 10; i++) {
      stars[i] = await GameProgress.getStars(i);
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
              // Top bar
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
                        'Escolha o Nível',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppTheme.levelSelectTitleFontSize,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.levelSelectTitleColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Balancear o botão voltar
                  ],
                ),
              ),

              // Grid de níveis
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
                    itemCount: LevelConfig.levels.length,
                    itemBuilder: (context, index) {
                      final level = LevelConfig.levels[index];
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

  Widget _buildLevelCard(LevelData level, bool isUnlocked, int starCount) {
    return GestureDetector(
      onTap: isUnlocked
          ? () async {
              await Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => GameScreen(levelIndex: level.level - 1),
                  transitionsBuilder: (c, animation, a2, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 400),
                ),
              );
              _loadProgress(); // Recarrega ao voltar
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isUnlocked
              ? AppTheme.levelCardUnlockedColor
              : AppTheme.levelCardLockedColor,
          borderRadius: BorderRadius.circular(AppTheme.levelCardBorderRadius),
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: AppTheme.levelCardUnlockedColor.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isUnlocked) ...[
              Text(
                '${level.level}',
                style: const TextStyle(
                  fontSize: AppTheme.levelCardNumberFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                level.name,
                style: const TextStyle(
                  fontSize: AppTheme.levelCardLabelFontSize,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 8),
              // Estrelas
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) {
                  return Icon(
                    i < starCount ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: AppTheme.levelCardStarColor,
                    size: AppTheme.levelCardStarSize,
                  );
                }),
              ),
              const SizedBox(height: 4),
              Text(
                '${level.rows}x${level.cols}',
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white54,
                ),
              ),
            ] else ...[
              Icon(
                Icons.lock_rounded,
                color: AppTheme.levelCardLockedIconColor,
                size: 36,
              ),
              const SizedBox(height: 4),
              Text(
                'Nível ${level.level}',
                style: const TextStyle(
                  fontSize: AppTheme.levelCardLabelFontSize,
                  color: Color(0xFF555555),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
