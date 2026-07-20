import 'package:flutter/material.dart';

import '../theme/app_text.dart';

/// Rounded gradient header shared by the color-band and compound screens.
class KnowledgeHeader extends StatelessWidget {
  const KnowledgeHeader({
    super.key,
    required this.color,
    required this.colorLight,
    required this.onColor,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.emoji,
    this.iconAsset,
    this.trailing,
  });

  final Color color;
  final Color colorLight;
  final Color onColor;
  final String eyebrow;
  final String title;
  final String? subtitle;
  final String? emoji;

  /// When set, drawn instead of [emoji] inside the icon box.
  final String? iconAsset;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, colorLight],
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleBtn(
                    onColor: onColor,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (emoji != null || iconAsset != null) ...[
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: onColor == Colors.white
                            ? Colors.white.withOpacity(0.2)
                            : Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: iconAsset != null
                              ? Padding(
                                  padding: const EdgeInsets.all(11),
                                  child: Image.asset(iconAsset!),
                                )
                              : Text(emoji!,
                                  style: const TextStyle(fontSize: 34))),
                    ),
                    const SizedBox(width: 14),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(eyebrow.toUpperCase(),
                            style: AppText.body(
                                size: 12,
                                weight: FontWeight.w700,
                                letterSpacing: 0.8,
                                color: onColor.withOpacity(0.85))),
                        const SizedBox(height: 3),
                        Text(title,
                            style: AppText.fredoka(size: 25, color: onColor)),
                        if (subtitle != null) ...[
                          const SizedBox(height: 3),
                          Text(subtitle!,
                              style: AppText.body(
                                  size: 13.5,
                                  height: 1.4,
                                  color: onColor.withOpacity(0.92))),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleBtn extends StatelessWidget {
  const _CircleBtn({required this.onColor, required this.onTap});
  final Color onColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: onColor == Colors.white
              ? Colors.white.withOpacity(0.22)
              : Colors.black.withOpacity(0.08),
        ),
        child: Icon(Icons.arrow_back_rounded, color: onColor, size: 20),
      ),
    );
  }
}
