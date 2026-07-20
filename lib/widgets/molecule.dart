import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A stylised skeletal drawing of the curcumin molecule — two aromatic rings
/// (each carrying an -OH and an -OCH₃ group) joined by a diketone chain.
/// Purely decorative; it mirrors the chemical-structure image in the proposal.
class CurcuminStructure extends StatelessWidget {
  const CurcuminStructure({super.key, this.color = const Color(0xFF7A5B00)});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 320 / 132,
      child: CustomPaint(painter: _CurcuminPainter(color)),
    );
  }
}

class _CurcuminPainter extends CustomPainter {
  _CurcuminPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 320.0;
    Offset p(double x, double y) => Offset(x * s, y * s);

    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2 * s
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = color;

    // ── Two aromatic rings ──
    _hexagon(canvas, p(52, 66), 24 * s, line);
    _hexagon(canvas, p(268, 66), 24 * s, line);
    // aromatic "ring" circles
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6 * s
      ..color = color.withOpacity(0.7);
    canvas.drawCircle(p(52, 66), 14 * s, ring);
    canvas.drawCircle(p(268, 66), 14 * s, ring);

    // ── Substituent stubs on the left ring (HO- and CH₃O-) ──
    canvas.drawLine(p(28, 52), p(14, 44), line);
    canvas.drawLine(p(28, 80), p(14, 88), line);
    // right ring (mirrored)
    canvas.drawLine(p(292, 52), p(306, 44), line);
    canvas.drawLine(p(292, 80), p(306, 88), line);

    // ── Central conjugated diketone chain ──
    final chain = <Offset>[
      p(76, 66),
      p(104, 52),
      p(132, 66),
      p(160, 52),
      p(188, 66),
      p(216, 52),
      p(244, 66),
    ];
    for (var i = 0; i < chain.length - 1; i++) {
      canvas.drawLine(chain[i], chain[i + 1], line);
    }
    // double-bond ticks on alternating segments
    _doubleBond(canvas, chain[0], chain[1], line, s);
    _doubleBond(canvas, chain[2], chain[3], line, s);
    _doubleBond(canvas, chain[4], chain[5], line, s);

    // two carbonyls (C=O) pointing up from the two lower vertices
    _carbonyl(canvas, p(132, 66), line, s);
    _carbonyl(canvas, p(188, 66), line, s);

    // ── Atom labels ──
    _label(canvas, 'HO', p(2, 40), s, color, 12);
    _label(canvas, 'O', p(2, 84), s, color, 12);
    _label(canvas, 'CH₃', p(2, 98), s, color, 10);
    _label(canvas, 'OH', p(300, 40), s, color, 12);
    _label(canvas, 'O', p(310, 84), s, color, 12);
    _label(canvas, 'H₃C', p(292, 98), s, color, 10);
    _label(canvas, 'O', p(126, 30), s, color, 12);
    _label(canvas, 'O', p(182, 30), s, color, 12);
  }

  void _hexagon(Canvas canvas, Offset c, double r, Paint paint) {
    final path = Path();
    for (var i = 0; i < 6; i++) {
      final a = (60 * i - 30) * math.pi / 180;
      final pt = Offset(c.dx + r * math.cos(a), c.dy + r * math.sin(a));
      if (i == 0) {
        path.moveTo(pt.dx, pt.dy);
      } else {
        path.lineTo(pt.dx, pt.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _carbonyl(Canvas canvas, Offset base, Paint paint, double s) {
    // vertical double line to an O above
    canvas.drawLine(base, Offset(base.dx, base.dy - 24 * s), paint);
    canvas.drawLine(Offset(base.dx + 3 * s, base.dy),
        Offset(base.dx + 3 * s, base.dy - 24 * s), paint);
  }

  void _doubleBond(Canvas canvas, Offset a, Offset b, Paint paint, double s) {
    // draw a short parallel line slightly offset above the segment
    final dx = b.dx - a.dx;
    final dy = b.dy - a.dy;
    final len = math.sqrt(dx * dx + dy * dy);
    if (len == 0) return;
    final nx = -dy / len * 3 * s;
    final ny = dx / len * 3 * s;
    canvas.drawLine(
      Offset(a.dx * 0.75 + b.dx * 0.25 + nx, a.dy * 0.75 + b.dy * 0.25 + ny),
      Offset(a.dx * 0.25 + b.dx * 0.75 + nx, a.dy * 0.25 + b.dy * 0.75 + ny),
      paint,
    );
  }

  void _label(Canvas canvas, String text, Offset at, double s, Color color,
      double fontSize) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
            color: color, fontSize: fontSize * s, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, at);
  }

  @override
  bool shouldRepaint(covariant _CurcuminPainter old) => old.color != color;
}
