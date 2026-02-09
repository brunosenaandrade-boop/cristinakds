import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class HangmanDrawing extends StatelessWidget {
  final int errors;
  final int maxErrors;

  const HangmanDrawing({
    super.key,
    required this.errors,
    required this.maxErrors,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(180, 200),
      painter: _HangmanPainter(errors: errors),
    );
  }
}

class _HangmanPainter extends CustomPainter {
  final int errors;

  _HangmanPainter({required this.errors});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.hangmanStrokeColor
      ..strokeWidth = AppTheme.hangmanStrokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final bodyPaint = Paint()
      ..color = AppTheme.hangmanBodyColor
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Base (sempre visível)
    canvas.drawLine(
      Offset(20, size.height - 10),
      Offset(size.width - 20, size.height - 10),
      paint,
    );

    // Poste vertical
    canvas.drawLine(
      Offset(50, size.height - 10),
      const Offset(50, 20),
      paint,
    );

    // Poste horizontal
    canvas.drawLine(
      const Offset(50, 20),
      const Offset(140, 20),
      paint,
    );

    // Corda
    canvas.drawLine(
      const Offset(140, 20),
      const Offset(140, 45),
      paint,
    );

    // === Partes do corpo baseadas nos erros ===

    // 1. Cabeça
    if (errors >= 1) {
      canvas.drawCircle(const Offset(140, 62), 17, bodyPaint);
    }

    // 2. Corpo
    if (errors >= 2) {
      canvas.drawLine(
        const Offset(140, 79),
        const Offset(140, 130),
        bodyPaint,
      );
    }

    // 3. Braço esquerdo
    if (errors >= 3) {
      canvas.drawLine(
        const Offset(140, 92),
        const Offset(115, 115),
        bodyPaint,
      );
    }

    // 4. Braço direito
    if (errors >= 4) {
      canvas.drawLine(
        const Offset(140, 92),
        const Offset(165, 115),
        bodyPaint,
      );
    }

    // 5. Perna esquerda
    if (errors >= 5) {
      canvas.drawLine(
        const Offset(140, 130),
        const Offset(118, 165),
        bodyPaint,
      );
    }

    // 6. Perna direita
    if (errors >= 6) {
      canvas.drawLine(
        const Offset(140, 130),
        const Offset(162, 165),
        bodyPaint,
      );
    }

    // 7. Rosto triste (opcional, erro extra)
    if (errors >= 7) {
      final facePaint = Paint()
        ..color = AppTheme.hangmanBodyColor
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      // Olhos X
      canvas.drawLine(const Offset(133, 57), const Offset(137, 63), facePaint);
      canvas.drawLine(const Offset(137, 57), const Offset(133, 63), facePaint);
      canvas.drawLine(const Offset(143, 57), const Offset(147, 63), facePaint);
      canvas.drawLine(const Offset(147, 57), const Offset(143, 63), facePaint);

      // Boca triste
      final mouthPath = Path()
        ..moveTo(133, 72)
        ..quadraticBezierTo(140, 67, 147, 72);
      canvas.drawPath(mouthPath, facePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _HangmanPainter oldDelegate) {
    return oldDelegate.errors != errors;
  }
}
