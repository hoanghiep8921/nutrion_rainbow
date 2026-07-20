import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';

/// Reusable soft shadows matching the template's card styling.
class AppShadows {
  AppShadows._();

  static List<BoxShadow> get soft => [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get small => [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> glow(Color color, {double opacity = 0.3}) => [
        BoxShadow(
          color: color.withOpacity(opacity),
          blurRadius: 22,
          offset: const Offset(0, 10),
        ),
      ];
}

/// A full-width pill button (solid color or gradient).
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color,
    this.gradient,
    this.textColor = Colors.white,
    this.glowColor,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onTap;
  final Color? color;
  final Gradient? gradient;
  final Color textColor;
  final Color? glowColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final resolvedColor = color ?? AppColors.green;
    final glow = glowColor ?? (color ?? AppColors.green);
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: enabled ? onTap : null,
          child: Ink(
            decoration: BoxDecoration(
              color: gradient == null ? resolvedColor : null,
              gradient: gradient,
              borderRadius: BorderRadius.circular(100),
              boxShadow: enabled ? AppShadows.glow(glow, opacity: 0.32) : null,
            ),
            child: Container(
              height: 56,
              alignment: Alignment.center,
              child: Text(
                label,
                style: AppText.fredoka(
                  size: 17,
                  weight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A gentle up-and-down floating animation (mirrors the CSS `nr-float`).
class Bob extends StatefulWidget {
  const Bob({super.key, required this.child, this.distance = 8, this.seconds = 5});

  final Widget child;
  final double distance;
  final int seconds;

  @override
  State<Bob> createState() => _BobState();
}

class _BobState extends State<Bob> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: Duration(seconds: widget.seconds),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(parent: _c, curve: Curves.easeInOut);
    return AnimatedBuilder(
      animation: curved,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, -widget.distance * curved.value),
        child: child,
      ),
      child: widget.child,
    );
  }
}

/// A small pill chip (e.g. the streak counter).
class Pill extends StatelessWidget {
  const Pill({
    super.key,
    required this.child,
    required this.background,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  });

  final Widget child;
  final Color background;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(100),
      ),
      child: child,
    );
  }
}

/// A compact cluster of representative food emojis (e.g. a vegetable + a
/// meat/fish) used on color cards so the icon reflects mixed food types.
class FoodIcons extends StatelessWidget {
  const FoodIcons(this.icons, {super.key, this.size = 22, this.spacing = 2});

  final List<String> icons;
  final double size;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < icons.length; i++) ...[
          if (i > 0) SizedBox(width: spacing),
          Text(icons[i], style: TextStyle(fontSize: size)),
        ],
      ],
    );
  }
}
