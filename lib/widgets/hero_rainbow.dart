import 'dart:math' as math;
import 'dart:ui' show PathOperation;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A small, decorative rainbow-with-sun illustration for the Home hero
/// (mirrors the cartoon reference image). Purely visual — not interactive.
class HeroRainbow extends StatelessWidget {
  const HeroRainbow({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(painter: _HeroRainbowPainter()),
    );
  }
}

class _HeroRainbowPainter extends CustomPainter {
  static const List<Color> _bands = [
    AppColors.red,
    AppColors.orange,
    AppColors.yellow,
    AppColors.green,
    AppColors.blue,
  ];
  static const Color _outline = Color(0xFF2A2925);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.52;
    final cy = h * 0.88;
    final outerR = w * 0.46;
    final t = (outerR * 0.55) / _bands.length;

    // ── Rainbow bands (outer red → inner blue) ──
    for (var i = 0; i < _bands.length; i++) {
      final rMid = outerR - i * t - t / 2;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = t
        ..color = _bands[i];
      canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy), radius: rMid),
          math.pi, math.pi, false, paint);
    }
    final outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = _outline;
    for (var i = 0; i <= _bands.length; i++) {
      final r = outerR - i * t;
      canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy), radius: r),
          math.pi, math.pi, false, outline);
    }

    // ── Clouds over the band ends ──
    final innerR = outerR - t * _bands.length;
    final endMid = (outerR + innerR) / 2;
    _cloud(canvas, Offset(cx - endMid, cy + 1), w * 0.016);
    _cloud(canvas, Offset(cx + endMid, cy + 1), w * 0.018);

    // ── Smiling sun (top-left) ──
    _sun(canvas, Offset(w * 0.24, h * 0.26), w * 0.12);
  }

  void _sun(Canvas canvas, Offset c, double r) {
    final rays = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..color = _outline;
    for (var i = 0; i < 8; i++) {
      final a = i * math.pi / 4;
      final p1 = Offset(c.dx + math.cos(a) * r * 1.35,
          c.dy + math.sin(a) * r * 1.35);
      final p2 = Offset(
          c.dx + math.cos(a) * r * 1.75, c.dy + math.sin(a) * r * 1.75);
      canvas.drawLine(p1, p2, rays);
    }
    canvas.drawCircle(c, r, Paint()..color = AppColors.yellow);
    canvas.drawCircle(
        c,
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.4
          ..color = _outline);
    // face
    final face = Paint()..color = _outline;
    canvas.drawCircle(Offset(c.dx - r * 0.34, c.dy - r * 0.12), r * 0.1, face);
    canvas.drawCircle(Offset(c.dx + r * 0.34, c.dy - r * 0.12), r * 0.1, face);
    final smile = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..color = _outline;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(c.dx, c.dy + r * 0.05), radius: r * 0.42),
        0.15 * math.pi,
        0.7 * math.pi,
        false,
        smile);
  }

  void _cloud(Canvas canvas, Offset base, double s) {
    Path circle(double dx, double dy, double rr) => Path()
      ..addOval(Rect.fromCircle(
          center: Offset(base.dx + dx * s, base.dy + dy * s), radius: rr * s));
    var cloud = circle(-16, -2, 12);
    cloud = Path.combine(PathOperation.union, cloud, circle(-2, -12, 16));
    cloud = Path.combine(PathOperation.union, cloud, circle(14, -4, 13));
    cloud = Path.combine(
        PathOperation.union,
        cloud,
        Path()
          ..addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(base.dx - 28 * s, base.dy - 5 * s, 56 * s, 13 * s),
            Radius.circular(8 * s),
          )));
    canvas.drawPath(cloud, Paint()..color = Colors.white);
    canvas.drawPath(
        cloud,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..strokeJoin = StrokeJoin.round
          ..color = _outline);
  }

  @override
  bool shouldRepaint(covariant _HeroRainbowPainter oldDelegate) => false;
}
