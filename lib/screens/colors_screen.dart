import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/nutrition_data.dart';
import '../models/models.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';
import 'lesson_detail_screen.dart';

class ColorsScreen extends StatelessWidget {
  const ColorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final en = state.isEnglish;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(en ? 'The 6 nutrition colors' : '6 màu dinh dưỡng',
                style: AppText.fredoka(size: 26)),
            const SizedBox(height: 2),
            Text(
                en
                    ? 'Each color, its own nutrients · Tap to learn'
                    : 'Mỗi màu, một nhóm dưỡng chất riêng · Tap to learn',
                style: AppText.body(size: 14, color: AppColors.muted2)),
            const SizedBox(height: 20),
            for (final c in kColors) ...[
              _ColorCard(
                color: c,
                en: en,
                status: state.statusOf(c.id),
                progress: state.progressOf(c.id),
                onTap: state.isUnlocked(c.id)
                    ? () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => LessonDetailScreen(color: c)),
                        )
                    : null,
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}

class _ColorCard extends StatelessWidget {
  const _ColorCard({
    required this.color,
    required this.en,
    required this.status,
    required this.progress,
    required this.onTap,
  });

  final NutritionColorInfo color;
  final bool en;
  final ColorStatus status;
  final double progress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final locked = status == ColorStatus.locked;
    return GestureDetector(
      onTap: onTap,
      child: locked ? _lockedCard() : _unlockedCard(),
    );
  }

  Widget _unlockedCard() {
    final completed = status == ColorStatus.completed;
    final onColor = color.onColor;
    final badgeBg = color.onColor == Colors.white
        ? Colors.white.withOpacity(0.22)
        : const Color(0xFF7A5B00).withOpacity(0.16);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [color.color, color.colorLight]),
        boxShadow: AppShadows.glow(color.color, opacity: 0.28),
      ),
      child: Row(
        children: [
          FoodIcons(color.icons, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    en
                        ? '${color.nameEn} · ${color.compound}'
                        : '${color.name} · ${color.compound}',
                    style: AppText.fredoka(size: 18, color: onColor)),
                const SizedBox(height: 2),
                Text(en ? color.benefitEn : color.benefit,
                    style: AppText.body(
                        size: 13, color: onColor.withOpacity(0.9))),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Pill(
            background: badgeBg,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              completed ? '✓ 100%' : '${(progress * 100).round()}%',
              style: AppText.body(
                  size: 12, weight: FontWeight.w700, color: onColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _lockedCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.lineDark, width: 2),
      ),
      child: Row(
        children: [
          FoodIcons(color.icons, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    en
                        ? '${color.nameEn} · ${color.compound}'
                        : '${color.name} · ${color.compound}',
                    style: AppText.fredoka(size: 18, color: color.color)),
                const SizedBox(height: 2),
                Text(en ? color.benefitEn : color.benefit,
                    style: AppText.body(size: 13, color: AppColors.muted2)),
              ],
            ),
          ),
          const Text('🔒', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
