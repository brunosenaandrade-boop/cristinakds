import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../config/app_sizes.dart';
import 'star_rating.dart';

class VictoryDialog extends StatefulWidget {
  final int stars;
  final int moves;
  final String time;
  final String levelName;
  final bool hasNextLevel;
  final String movesLabel;
  final VoidCallback onReplay;
  final VoidCallback onNextLevel;
  final VoidCallback onMenu;

  const VictoryDialog({
    super.key,
    required this.stars,
    required this.moves,
    required this.time,
    required this.levelName,
    required this.hasNextLevel,
    this.movesLabel = 'Jogadas',
    required this.onReplay,
    required this.onNextLevel,
    required this.onMenu,
  });

  @override
  State<VictoryDialog> createState() => _VictoryDialogState();
}

class _VictoryDialogState extends State<VictoryDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getMessage() {
    switch (widget.stars) {
      case 3:
        return 'Perfeito! Incrivel!';
      case 2:
        return 'Muito bem! Continue assim!';
      default:
        return 'Parabens! Voce conseguiu!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: AppSizes.victoryDialogWidth,
          padding: const EdgeInsets.all(AppSizes.victoryDialogPadding),
          decoration: BoxDecoration(
            color: AppTheme.victoryBackgroundColor,
            borderRadius: BorderRadius.circular(AppSizes.victoryDialogBorderRadius),
            border: Border.all(
              color: AppTheme.victoryStarColor.withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Emoji celebracao
              const Text('🎉', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),

              // Titulo
              const Text(
                'Nivel Completo!',
                style: TextStyle(
                  fontSize: AppTheme.victoryTitleFontSize,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.victoryTitleColor,
                ),
              ),
              const SizedBox(height: 16),

              // Estrelas
              StarRating(stars: widget.stars),
              const SizedBox(height: 16),

              // Mensagem
              Text(
                _getMessage(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: AppTheme.victoryMessageFontSize,
                  color: AppTheme.victoryMessageColor,
                ),
              ),
              const SizedBox(height: 20),

              // Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat(widget.movesLabel, '${widget.moves}', Icons.touch_app_rounded),
                  _buildStat('Tempo', widget.time, Icons.timer_rounded),
                ],
              ),
              const SizedBox(height: 24),

              // Botoes
              if (widget.hasNextLevel)
                SizedBox(
                  width: double.infinity,
                  height: AppSizes.victoryButtonHeight,
                  child: ElevatedButton(
                    onPressed: widget.onNextLevel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.victoryNextButtonColor,
                      foregroundColor: AppTheme.victoryButtonTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Proximo Nivel  ➡️',
                      style: TextStyle(
                        fontSize: AppTheme.victoryButtonFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: AppSizes.victoryButtonSpacing),

              // Jogar novamente
              SizedBox(
                width: double.infinity,
                height: AppSizes.victoryButtonHeight,
                child: ElevatedButton(
                  onPressed: widget.onReplay,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.victoryButtonColor,
                    foregroundColor: AppTheme.victoryButtonTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Jogar Novamente  🔄',
                    style: TextStyle(
                      fontSize: AppTheme.victoryButtonFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.victoryButtonSpacing),

              // Voltar ao menu
              TextButton(
                onPressed: widget.onMenu,
                child: const Text(
                  'Voltar ao Menu',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.accentColor, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }
}
