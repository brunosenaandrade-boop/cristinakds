import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class StarRating extends StatelessWidget {
  final int stars;
  final double size;

  const StarRating({
    super.key,
    required this.stars,
    this.size = AppTheme.victoryStarSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isFilled = index < stars;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: AnimatedScale(
            scale: isFilled ? 1.0 : 0.8,
            duration: Duration(milliseconds: 300 + (index * 200)),
            child: Icon(
              isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
              color: isFilled
                  ? AppTheme.victoryStarColor
                  : AppTheme.victoryStarEmptyColor,
              size: size,
            ),
          ),
        );
      }),
    );
  }
}
