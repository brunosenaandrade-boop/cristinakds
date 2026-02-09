import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../config/app_sizes.dart';
import 'level_select_screen.dart';
import 'word_search_level_screen.dart';
import 'hangman_level_screen.dart';
import 'quiz_level_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  void _navigateTo(Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => screen,
        transitionsBuilder: (c, animation, a2, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.homeGradientTop,
              AppTheme.homeGradientBottom,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo animado
                  AnimatedBuilder(
                    animation: _floatAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _floatAnimation.value),
                        child: child,
                      );
                    },
                    child: Container(
                      width: AppSizes.homeLogoSize,
                      height: AppSizes.homeLogoSize,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text('🧒', style: TextStyle(fontSize: 64)),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSizes.homeSpacingTitle),

                  // Título
                  const Text(
                    'CristinaKids',
                    style: TextStyle(
                      fontSize: AppTheme.homeTitleFontSize,
                      fontWeight: AppTheme.homeTitleFontWeight,
                      color: AppTheme.homeTitleColor,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtítulo
                  const Text(
                    'Escolha um jogo para se divertir!',
                    style: TextStyle(
                      fontSize: AppTheme.homeSubtitleFontSize,
                      color: AppTheme.homeSubtitleColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // ====== BOTÃO JOGO DA MEMÓRIA ======
                  _buildGameButton(
                    emoji: '🃏',
                    title: 'Jogo da Memória',
                    subtitle: 'Encontre os pares!',
                    color: AppTheme.homeMemoryButtonColor,
                    onTap: () => _navigateTo(const LevelSelectScreen()),
                  ),

                  const SizedBox(height: 20),

                  // ====== BOTÃO CAÇA-PALAVRAS ======
                  _buildGameButton(
                    emoji: '🔍',
                    title: 'Caça-Palavras',
                    subtitle: 'Encontre as palavras escondidas!',
                    color: AppTheme.homeWordSearchButtonColor,
                    onTap: () => _navigateTo(const WordSearchLevelScreen()),
                  ),

                  const SizedBox(height: 20),

                  // ====== BOTÃO JOGO DA FORCA ======
                  _buildGameButton(
                    emoji: '🪢',
                    title: 'Jogo da Forca',
                    subtitle: 'Adivinhe a palavra secreta!',
                    color: AppTheme.homeHangmanButtonColor,
                    onTap: () => _navigateTo(const HangmanLevelScreen()),
                  ),

                  const SizedBox(height: 20),

                  // ====== BOTÃO QUIZ ======
                  _buildGameButton(
                    emoji: '🧠',
                    title: 'Quiz de Conhecimentos',
                    subtitle: 'Teste o que você sabe!',
                    color: AppTheme.homeQuizButtonColor,
                    onTap: () => _navigateTo(const QuizLevelScreen()),
                  ),

                  const SizedBox(height: 40),

                  // Emojis decorativos
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🐶', style: TextStyle(fontSize: 28)),
                      SizedBox(width: 12),
                      Text('🍎', style: TextStyle(fontSize: 28)),
                      SizedBox(width: 12),
                      Text('⚽', style: TextStyle(fontSize: 28)),
                      SizedBox(width: 12),
                      Text('🌸', style: TextStyle(fontSize: 28)),
                      SizedBox(width: 12),
                      Text('🦋', style: TextStyle(fontSize: 28)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameButton({
    required String emoji,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppTheme.homeGameButtonBorderRadius),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.homeGameButtonPaddingH,
              vertical: AppTheme.homeGameButtonPaddingV + 4,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppTheme.homeGameButtonBorderRadius),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 40)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: AppTheme.homeGameButtonFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
