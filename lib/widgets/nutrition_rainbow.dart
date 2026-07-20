import 'dart:math' as math;
import 'dart:ui' show PathOperation;

import 'package:flutter/material.dart';

import '../data/knowledge_data.dart';
import '../models/knowledge_models.dart';

/// The interactive Nutrition Rainbow.
///
/// Draws one semicircular color band per entry in [kBands] (red on the
/// outside → purple on the inside) with two decorative clouds and no sun,
/// matching the project proposal. Each band is tappable; tapping calls
/// [onBandTap] with the band id (`red`, `orange`, `yellow`, `green`, `blue`,
/// `purple`). The clouds are not interactive.
class InteractiveRainbow extends StatefulWidget {
  const InteractiveRainbow({super.key, required this.onBandTap});

  final ValueChanged<String> onBandTap;

  @override
  State<InteractiveRainbow> createState() => _InteractiveRainbowState();
}

class _InteractiveRainbowState extends State<InteractiveRainbow> {
  // Bands from the data, outer → inner (red, orange, yellow, green, blue).
  List<RainbowBand> get _bands => kBands;

  int? _highlight; // band index briefly highlighted on tap

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final geo = _RainbowGeometry.forWidth(w, _bands.length);

        return SizedBox(
          width: w,
          height: geo.height,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (details) => _handleTap(details.localPosition, geo),
            child: ClipRect(
              child: CustomPaint(
                painter: _RainbowPainter(
                  bands: _bands,
                  geo: geo,
                  highlight: _highlight,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleTap(Offset p, _RainbowGeometry geo) {
    final index = geo.bandIndexAt(p, _bands.length);
    if (index == null) return;
    setState(() => _highlight = index);
    Future.delayed(const Duration(milliseconds: 220), () {
      // Only clear if this tap's highlight is still the active one.
      if (mounted && _highlight == index) setState(() => _highlight = null);
    });
    widget.onBandTap(_bands[index].id);
  }
}

/// Pure geometry + hit-testing for the rainbow, shared by painter and taps.
class _RainbowGeometry {
  _RainbowGeometry({
    required this.center,
    required this.outerRadius,
    required this.bandThickness,
    required this.bandCount,
    required this.height,
  });

  final Offset center; // arc centre (on the baseline)
  final double outerRadius;
  final double bandThickness;
  final int bandCount;
  final double height;

  double get innerRadius => outerRadius - bandThickness * bandCount;

  static _RainbowGeometry forWidth(double w, int bandCount) {
    final outer = (w / 2) - 26; // extra side margin so clouds never touch edges
    final thickness = (outer * 0.58) / bandCount; // inner hole ≈ 42% of outer
    final cy = outer + 10;
    final height = cy + outer * 0.5; // room for the clouds + shadow below
    return _RainbowGeometry(
      center: Offset(w / 2, cy),
      outerRadius: outer,
      bandThickness: thickness,
      bandCount: bandCount,
      height: height,
    );
  }

  /// Returns the band index (0 = outer/red) hit by [p], or null for a miss.
  int? bandIndexAt(Offset p, int bandCount) {
    final dx = p.dx - center.dx;
    final dy = p.dy - center.dy;
    if (dy > 4) return null; // below the baseline (clouds / empty)
    final r = math.sqrt(dx * dx + dy * dy);
    if (r > outerRadius || r < innerRadius) return null;
    final i = ((outerRadius - r) / bandThickness).floor();
    return i.clamp(0, bandCount - 1);
  }
}

class _RainbowPainter extends CustomPainter {
  _RainbowPainter({
    required this.bands,
    required this.geo,
    required this.highlight,
  });

  final List<RainbowBand> bands;
  final _RainbowGeometry geo;
  final int? highlight;

  static const _outline = Color(0xFF2A2925);

  @override
  void paint(Canvas canvas, Size size) {
    final cx = geo.center.dx;
    final cy = geo.center.dy;
    final t = geo.bandThickness;

    // ── Colored bands (outer → inner) ──
    for (var i = 0; i < bands.length; i++) {
      final rOuter = geo.outerRadius - i * t;
      final rInner = rOuter - t;
      final rMid = (rOuter + rInner) / 2;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = t
        ..strokeCap = StrokeCap.butt
        ..color = highlight == i
            ? Color.lerp(bands[i].color, Colors.white, 0.28)!
            : bands[i].color;
      final rect = Rect.fromCircle(center: Offset(cx, cy), radius: rMid);
      canvas.drawArc(rect, math.pi, math.pi, false, paint);
    }

    // ── Cartoon black outlines on every band boundary ──
    final outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = _outline;
    for (var i = 0; i <= bands.length; i++) {
      final r = geo.outerRadius - i * t;
      final rect = Rect.fromCircle(center: Offset(cx, cy), radius: r);
      canvas.drawArc(rect, math.pi, math.pi, false, outline);
    }

    // ── Two decorative clouds over the band ends ──
    final leftEnd = cx - (geo.outerRadius + geo.innerRadius) / 2;
    final rightEnd = cx + (geo.outerRadius + geo.innerRadius) / 2;
    final cloudScale = geo.outerRadius * 0.013;
    _drawCloud(canvas, Offset(leftEnd, cy + 2), cloudScale);
    _drawCloud(canvas, Offset(rightEnd, cy + 2), cloudScale * 1.05);
  }

  void _drawCloud(Canvas canvas, Offset base, double s) {
    Path circle(double dx, double dy, double r) =>
        Path()..addOval(Rect.fromCircle(center: Offset(base.dx + dx * s, base.dy + dy * s), radius: r * s));

    var cloud = circle(-20, -2, 15);
    cloud = Path.combine(PathOperation.union, cloud, circle(-4, -14, 20));
    cloud = Path.combine(PathOperation.union, cloud, circle(16, -8, 16));
    cloud = Path.combine(
        PathOperation.union,
        cloud,
        Path()
          ..addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(base.dx - 34 * s, base.dy - 6 * s, 68 * s, 16 * s),
            Radius.circular(10 * s),
          )));

    final fill = Paint()..color = Colors.white;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeJoin = StrokeJoin.round
      ..color = _outline;
    canvas.drawShadow(cloud, Colors.black.withOpacity(0.18), 4, true);
    canvas.drawPath(cloud, fill);
    canvas.drawPath(cloud, stroke);
  }

  @override
  bool shouldRepaint(covariant _RainbowPainter old) =>
      // A width change relayouts (and repaints) the CustomPaint on its own,
      // so we only need to repaint here when the tapped band changes.
      old.highlight != highlight;
}
