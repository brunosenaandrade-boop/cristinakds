import 'package:flutter/material.dart';

/// ============================================================
/// ARQUIVO CENTRAL DE TEMA - CristinaKids
/// ============================================================
/// Quer mudar qualquer cor, fonte ou estilo do app?
/// Mude AQUI e o app inteiro atualiza!
/// ============================================================
class AppTheme {
  // ===== CORES PRINCIPAIS DO APP =====
  static const primaryColor = Color(0xFF6C63FF); // Roxo principal
  static const secondaryColor = Color(0xFFFF6584); // Rosa/coral
  static const accentColor = Color(0xFFFFD93D); // Amarelo dourado
  static const backgroundColor = Color(0xFF1A1A2E); // Fundo escuro
  static const surfaceColor = Color(0xFF16213E); // Superfície cards
  static const successColor = Color(0xFF00C851); // Verde sucesso

  // ===== TELA INICIAL (HOME) =====
  static const homeGradientTop = Color(0xFF667EEA); // Gradiente topo
  static const homeGradientBottom = Color(0xFF764BA2); // Gradiente base
  static const homeTitleColor = Colors.white;
  static const homeTitleFontSize = 42.0;
  static const homeTitleFontWeight = FontWeight.w900;
  static const homeSubtitleColor = Color(0xFFE0E0E0);
  static const homeSubtitleFontSize = 18.0;
  static const homeButtonColor = Color(0xFFFF6584);
  static const homeButtonTextColor = Colors.white;
  static const homeButtonFontSize = 22.0;
  static const homeButtonBorderRadius = 30.0;
  static const homeButtonPaddingH = 50.0; // Horizontal
  static const homeButtonPaddingV = 18.0; // Vertical

  // ===== TELA DE SELEÇÃO DE NÍVEIS =====
  static const levelSelectGradientTop = Color(0xFF0F0C29);
  static const levelSelectGradientMiddle = Color(0xFF302B63);
  static const levelSelectGradientBottom = Color(0xFF24243E);
  static const levelSelectTitleColor = Colors.white;
  static const levelSelectTitleFontSize = 28.0;
  static const levelCardUnlockedColor = Color(0xFF6C63FF);
  static const levelCardLockedColor = Color(0xFF2D2D44);
  static const levelCardBorderRadius = 20.0;
  static const levelCardNumberFontSize = 28.0;
  static const levelCardLabelFontSize = 13.0;
  static const levelCardStarColor = Color(0xFFFFD93D);
  static const levelCardStarSize = 18.0;
  static const levelCardLockedIconColor = Color(0xFF555555);

  // ===== TELA DO JOGO =====
  static const gameGradientTop = Color(0xFF0F0C29);
  static const gameGradientBottom = Color(0xFF302B63);
  static const gameTopBarTextColor = Colors.white;
  static const gameTopBarFontSize = 16.0;
  static const gameTopBarIconColor = Color(0xFFFFD93D);
  static const gameLevelTitleFontSize = 20.0;

  // ===== CARTAS DO JOGO =====
  static const cardBackColor = Color(0xFF6C63FF); // Costas da carta
  static const cardBackIconColor = Color(0xFFFFFFFF); // Icone nas costas
  static const cardFrontColor = Color(0xFFF5F5F5); // Frente da carta
  static const cardMatchedColor = Color(0xFF00C851); // Carta acertada
  static const cardBorderRadius = 14.0;
  static const cardEmojiSize = 30.0;
  static const cardBackIcon = Icons.star_rounded;
  static const cardBackIconSize = 28.0;
  static const cardShadowColor = Color(0x40000000);
  static const cardShadowBlur = 8.0;
  static const cardFlipDuration = Duration(milliseconds: 400);
  static const cardMatchDelay = Duration(milliseconds: 800);

  // ===== DIÁLOGO DE VITÓRIA =====
  static const victoryBackgroundColor = Color(0xFF1A1A2E);
  static const victoryTitleColor = Color(0xFFFFD93D);
  static const victoryTitleFontSize = 32.0;
  static const victoryMessageColor = Colors.white;
  static const victoryMessageFontSize = 18.0;
  static const victoryStarColor = Color(0xFFFFD93D);
  static const victoryStarEmptyColor = Color(0xFF555555);
  static const victoryStarSize = 50.0;
  static const victoryButtonColor = Color(0xFF6C63FF);
  static const victoryButtonTextColor = Colors.white;
  static const victoryButtonFontSize = 16.0;
  static const victoryNextButtonColor = Color(0xFFFF6584);

  // ===== CAÇA-PALAVRAS: GRID =====
  static const wsCellBorderRadius = 4.0;
  static const wsCellBorderColor = Color(0x30FFFFFF);
  static const wsCellTextColor = Color(0xFFE0E0E0);
  static const wsCellFontSize = 18.0;
  static const wsSelectionColor = Color(0x80FFD93D); // Amarelo seleção
  static const wsSelectedLetterColor = Color(0xFF1A1A2E);
  static const wsFoundLetterColor = Colors.white;

  // ===== CAÇA-PALAVRAS: LISTA DE PALAVRAS =====
  static const wsWordListColor = Color(0xFFE0E0E0);
  static const wsWordFontSize = 14.0;
  static const wsWordChipBg = Color(0x15FFFFFF);
  static const wsWordChipBorder = Color(0x30FFFFFF);
  static const wsWordChipRadius = 20.0;

  // ===== CAÇA-PALAVRAS: CARD DO NÍVEL =====
  static const wsLevelCardColor = Color(0xFF00BCD4); // Ciano/teal

  // ===== HOME: BOTÕES DOS JOGOS =====
  static const homeMemoryButtonColor = Color(0xFFFF6584);
  static const homeWordSearchButtonColor = Color(0xFF00BCD4);
  static const homeHangmanButtonColor = Color(0xFFFF9800);
  static const homeQuizButtonColor = Color(0xFF8BC34A);
  static const homeGameButtonFontSize = 18.0;
  static const homeGameButtonPaddingH = 32.0;
  static const homeGameButtonPaddingV = 16.0;
  static const homeGameButtonBorderRadius = 20.0;

  // ===== JOGO DA FORCA =====
  static const hangmanLevelCardColor = Color(0xFFFF9800); // Laranja
  static const hangmanStrokeColor = Color(0xFF8D6E63); // Marrom madeira
  static const hangmanStrokeWidth = 3.5;
  static const hangmanBodyColor = Color(0xFFE0E0E0);
  static const hangmanWordFontSize = 32.0;
  static const hangmanKeyBg = Color(0xFF2D2D44);
  static const hangmanCorrectLetterBg = Color(0xFF00C851);
  static const hangmanWrongLetterBg = Color(0xFFFF6584);
  static const hangmanHintBg = Color(0x20FFFFFF);

  // ===== QUIZ =====
  static const quizLevelCardColor = Color(0xFF8BC34A); // Verde claro
  static const quizQuestionFontSize = 20.0;
  static const quizOptionFontSize = 16.0;
  static const quizCorrectBg = Color(0x3000C851);
  static const quizCorrectBorder = Color(0xFF00C851);
  static const quizWrongBg = Color(0x30FF6584);
  static const quizWrongBorder = Color(0xFFFF6584);

  // ===== FONTES =====
  static const fontFamily = 'Roboto';
}
