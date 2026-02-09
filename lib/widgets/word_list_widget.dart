import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../models/word_search_logic.dart';

class WordListWidget extends StatelessWidget {
  final List<PlacedWord> words;
  final List<Color> wordColors;

  const WordListWidget({
    super.key,
    required this.words,
    required this.wordColors,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 8,
      children: List.generate(words.length, (index) {
        final pw = words[index];
        final color = index < wordColors.length
            ? wordColors[index]
            : AppTheme.wsWordListColor;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: pw.found
                ? color.withValues(alpha: 0.25)
                : AppTheme.wsWordChipBg,
            borderRadius: BorderRadius.circular(AppTheme.wsWordChipRadius),
            border: Border.all(
              color: pw.found ? color : AppTheme.wsWordChipBorder,
              width: 1.5,
            ),
          ),
          child: Text(
            pw.word,
            style: TextStyle(
              fontSize: AppTheme.wsWordFontSize,
              fontWeight: FontWeight.bold,
              color: pw.found ? color : AppTheme.wsWordListColor,
              decoration: pw.found ? TextDecoration.lineThrough : null,
              decorationColor: color,
              decorationThickness: 2.5,
            ),
          ),
        );
      }),
    );
  }
}
