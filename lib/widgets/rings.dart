import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A decorative rainbow ring (conic/sweep gradient) with a centred child —
/// used for the onboarding logo.
class RainbowRing extends StatelessWidget {
  const RainbowRing({
    super.key,
    required this.size,
    required this.ringWidth,
    required this.child,
    this.innerColor = AppColors.bgSoft,
  });

  final double size;
  final double ringWidth;
  final Widget child;
  final Color innerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(colors: AppColors.rainbow),
      ),
      child: Padding(
        padding: EdgeInsets.all(ringWidth),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: innerColor,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

/// A circular progress ring (track + arc) with a centred child — used for the
/// daily-goal and quiz-result rings.
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.size,
    required this.progress,
    required this.child,
    this.strokeWidth = 12,
    this.trackColor = AppColors.lineDark,
    this.progressColor = AppColors.green,
  });

  final double size;
  final double progress; // 0..1
  final Widget child;
  final double strokeWidth;
  final Color trackColor;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(
          progress: progress.clamp(0.0, 1.0),
          track: trackColor,
          progress2: progressColor,
          stroke: strokeWidth,
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.track,
    required this.progress2,
    required this.stroke,
  });

  final double progress;
  final Color track;
  final Color progress2;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - stroke) / 2;

    final trackPaint = Paint()
      ..color = track
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;
    final progressPaint = Paint()
      ..color = progress2
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    const start = -math.pi / 2;
    final sweep = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      sweep,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.progress != progress ||
      old.track != track ||
      old.progress2 != progress2 ||
      old.stroke != stroke;
}

/// A thin horizontal progress bar (rounded), matching the lesson/home bars.
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.value,
    required this.color,
    this.height = 7,
    this.background = AppColors.line,
  });

  final double value; // 0..1
  final Color color;
  final double height;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: height,
        color: background,
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: value.clamp(0.0, 1.0),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
    );
  }
}
