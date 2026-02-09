import 'dart:math';
import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../models/card_model.dart';

class GameCard extends StatefulWidget {
  final CardModel card;
  final VoidCallback onTap;

  const GameCard({
    super.key,
    required this.card,
    required this.onTap,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;
  bool _showFront = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppTheme.cardFlipDuration,
    );

    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addListener(() {
      if (_controller.value >= 0.5 && !_showFront) {
        setState(() => _showFront = true);
      } else if (_controller.value < 0.5 && _showFront) {
        setState(() => _showFront = false);
      }
    });
  }

  @override
  void didUpdateWidget(GameCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.card.isFaceUp && !_showFront) {
      _controller.forward();
    } else if (!widget.card.isFaceUp && _showFront) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          final angle = _flipAnimation.value * pi;
          final isBack = _flipAnimation.value < 0.5;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: isBack ? _buildBack() : _buildFront(),
          );
        },
      ),
    );
  }

  Widget _buildBack() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackColor,
        borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cardShadowColor,
            blurRadius: AppTheme.cardShadowBlur,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          AppTheme.cardBackIcon,
          color: AppTheme.cardBackIconColor,
          size: AppTheme.cardBackIconSize,
        ),
      ),
    );
  }

  Widget _buildFront() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(pi),
      child: Container(
        decoration: BoxDecoration(
          color: widget.card.isMatched
              ? AppTheme.cardMatchedColor
              : AppTheme.cardFrontColor,
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
          boxShadow: [
            BoxShadow(
              color: widget.card.isMatched
                  ? AppTheme.cardMatchedColor.withValues(alpha: 0.4)
                  : AppTheme.cardShadowColor,
              blurRadius: AppTheme.cardShadowBlur,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.card.emoji,
            style: const TextStyle(fontSize: AppTheme.cardEmojiSize),
          ),
        ),
      ),
    );
  }
}
