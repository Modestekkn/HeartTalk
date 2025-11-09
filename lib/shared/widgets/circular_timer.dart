import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Timer circulaire animé avec progress ring
class CircularTimer extends StatelessWidget {
  final int totalSeconds;
  final int remainingSeconds;
  final double size;
  final double strokeWidth;

  const CircularTimer({
    super.key,
    required this.totalSeconds,
    required this.remainingSeconds,
    this.size = 120,
    this.strokeWidth = 8,
  });

  Color _getTimerColor() {
    final percentage = remainingSeconds / totalSeconds;
    if (percentage > 0.5) {
      return AppColors.success;
    } else if (percentage > 0.166) {
      // 30s sur 3min
      return AppColors.warning;
    } else {
      return AppColors.error;
    }
  }

  String _formatTime() {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final progress = remainingSeconds / totalSeconds;
    final color = _getTimerColor();

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          CustomPaint(
            size: Size(size, size),
            painter: _CircleBackgroundPainter(
              strokeWidth: strokeWidth,
              backgroundColor: AppColors.grey200,
            ),
          ),
          // Progress ring
          AnimatedBuilder(
            animation: AlwaysStoppedAnimation(progress),
            builder: (context, child) {
              return CustomPaint(
                size: Size(size, size),
                painter: _CircleProgressPainter(
                  progress: progress,
                  strokeWidth: strokeWidth,
                  color: color,
                ),
              );
            },
          ),
          // Timer text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  fontSize: size * 0.25,
                  fontWeight: FontWeight.bold,
                  color: color,
                  letterSpacing: -1,
                ),
                child: Text(_formatTime()),
              ),
              if (remainingSeconds <= 10) ...[
                SizedBox(height: size * 0.05),
                Icon(
                  Icons.warning_amber_rounded,
                  color: color,
                  size: size * 0.15,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _CircleBackgroundPainter extends CustomPainter {
  final double strokeWidth;
  final Color backgroundColor;

  _CircleBackgroundPainter({
    required this.strokeWidth,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CircleProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;

  _CircleProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Dessiner l'arc de progression (commence en haut et va dans le sens horaire)
    const startAngle = -math.pi / 2; // Commence en haut
    final sweepAngle = 2 * math.pi * progress; // Arc proportionnel au progrès

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );

    // Ajouter un effet glow si le temps est critique
    if (progress < 0.166) {
      final glowPaint = Paint()
        ..color = color.withValues(alpha: 0.3)
        ..strokeWidth = strokeWidth + 4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        glowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
