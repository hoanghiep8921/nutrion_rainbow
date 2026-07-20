import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/nutrition_data.dart';
import '../models/models.dart';
import '../state/app_state.dart';
import '../state/shell_controller.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';
import '../widgets/hero_rainbow.dart';
import '../widgets/rings.dart';
import 'lesson_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _greeting(bool en) {
    final h = DateTime.now().hour;
    if (en) {
      if (h < 11) return 'Good morning 👋';
      if (h < 18) return 'Good afternoon 👋';
      return 'Good evening 👋';
    }
    if (h < 11) return 'Chào buổi sáng 👋';
    if (h < 18) return 'Chào buổi chiều 👋';
    return 'Chào buổi tối 👋';
  }

  void _openLesson(BuildContext context, NutritionColorInfo c) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LessonDetailScreen(color: c)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final next = state.nextToLearn;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_greeting(state.isEnglish),
                          style: AppText.body(size: 14, color: AppColors.muted2)),
                      const SizedBox(height: 2),
                      Text(
                          state.isEnglish
                              ? 'Hi ${state.userName}!'
                              : '${state.userName} ơi!',
                          style: AppText.fredoka(size: 24)),
                    ],
                  ),
                ),
                Pill(
                  background: AppColors.streakBg,
                  child: Text('🔥 ${state.streak}',
                      style: AppText.body(
                          size: 14,
                          weight: FontWeight.w700,
                          color: AppColors.streak)),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => context
                      .read<ShellController>()
                      .goTo(ShellController.profile),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.purple, AppColors.blue],
                      ),
                    ),
                    child: const Center(
                        child: Text('🧑', style: TextStyle(fontSize: 22))),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ── Hero: slogan + illustration (proposal Home) ──
            const _HeroCard(),
            const SizedBox(height: 24),

            // ── Your progress (gamified dashboard) ──
            Text(state.isEnglish ? 'Your progress' : 'Tiến độ của bạn',
                style: AppText.fredoka(size: 17, weight: FontWeight.w500)),
            const SizedBox(height: 12),

            // ── Daily goal card ──
            _DailyGoalCard(completed: state.completedCount, en: state.isEnglish),
            const SizedBox(height: 20),

            // ── Rainbow row ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(state.isEnglish ? 'Your rainbow' : 'Cầu vồng của bạn',
                    style: AppText.fredoka(size: 17, weight: FontWeight.w500)),
                GestureDetector(
                  onTap: () =>
                      context.read<ShellController>().goTo(ShellController.colors),
                  child: Text(state.isEnglish ? 'See all' : 'Xem tất cả',
                      style: AppText.body(
                          size: 13,
                          weight: FontWeight.w600,
                          color: AppColors.green)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                for (var i = 0; i < kColors.length; i++) ...[
                  if (i > 0) const SizedBox(width: 10),
                  Expanded(
                    child: _RainbowTile(
                      color: kColors[i],
                      unlocked: state.isUnlocked(kColors[i].id),
                      onTap: state.isUnlocked(kColors[i].id)
                          ? () => _openLesson(context, kColors[i])
                          : null,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 22),

            // ── Continue learning ──
            if (next != null)
              _ContinueCard(
                color: next,
                progress: state.progressOf(next.id),
                onTap: () => _openLesson(context, next),
                en: state.isEnglish,
              ),
          ],
        ),
      ),
    );
  }
}

class _DailyGoalCard extends StatelessWidget {
  const _DailyGoalCard({required this.completed, required this.en});
  final int completed;
  final bool en;

  @override
  Widget build(BuildContext context) {
    final remaining = kColors.length - completed;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.greenDeep, AppColors.green],
        ),
        boxShadow: AppShadows.glow(AppColors.green, opacity: 0.28),
      ),
      child: Row(
        children: [
          ProgressRing(
            size: 88,
            strokeWidth: 10,
            progress: completed / kColors.length,
            trackColor: Colors.white.withOpacity(0.25),
            progressColor: Colors.white,
            child: Text('$completed/${kColors.length}',
                style: AppText.fredoka(size: 20, color: Colors.white)),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(en ? "Today's goal" : 'Mục tiêu hôm nay',
                    style: AppText.body(
                        size: 15, color: Colors.white.withOpacity(0.9))),
                const SizedBox(height: 4),
                Text(
                  remaining == 0
                      ? (en ? 'Full rainbow! 🌈' : 'Đủ cả cầu vồng! 🌈')
                      : (en
                          ? '$completed colors done!'
                          : 'Đủ $completed màu rồi!'),
                  style: AppText.fredoka(size: 20, color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  remaining == 0
                      ? (en
                          ? 'Awesome · keep it up!'
                          : 'Tuyệt vời · giữ vững phong độ!')
                      : (en
                          ? '$remaining more to go · +120 XP'
                          : 'Còn $remaining màu nữa · +120 XP'),
                  style: AppText.body(
                      size: 13, color: Colors.white.withOpacity(0.85)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RainbowTile extends StatelessWidget {
  const _RainbowTile({
    required this.color,
    required this.unlocked,
    required this.onTap,
  });

  final NutritionColorInfo color;
  final bool unlocked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: unlocked ? color.color : AppColors.lineDark,
            borderRadius: BorderRadius.circular(16),
            boxShadow:
                unlocked ? AppShadows.glow(color.color, opacity: 0.3) : null,
          ),
          child: Opacity(
            opacity: unlocked ? 1 : 0.55,
            child: Center(
              child: FoodIcons(color.icons, size: 15, spacing: 1),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContinueCard extends StatelessWidget {
  const _ContinueCard({
    required this.color,
    required this.progress,
    required this.onTap,
    required this.en,
  });

  final NutritionColorInfo color;
  final double progress;
  final VoidCallback onTap;
  final bool en;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: AppShadows.soft,
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.color.withOpacity(0.14),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(child: FoodIcons(color.icons, size: 22, spacing: 1)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(en ? 'CONTINUE LEARNING' : 'TIẾP TỤC HỌC',
                      style: AppText.body(
                          size: 12,
                          weight: FontWeight.w700,
                          letterSpacing: 0.6,
                          color: color.color)),
                  const SizedBox(height: 3),
                  Text(
                      en
                          ? '${color.nameEn} · ${color.compound}'
                          : 'Màu ${color.name} · ${color.compound}',
                      style: AppText.fredoka(size: 16, weight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  ProgressBar(value: progress, color: color.color),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color.color),
              child: const Center(
                child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The proposal-style hero: slogan on the left, rainbow-sun illustration on
/// the right, with a call-to-action into the Nutrition Rainbow tab.
class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.bgSoft, AppColors.bgSoft2],
        ),
        border: Border.all(color: AppColors.lineDark),
        boxShadow: AppShadows.soft,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          children: [
            // Rainbow illustration as a background (bleeds off-frame, clipped).
            Positioned(
              right: -30,
              bottom: -28,
              child: Opacity(
                opacity: 0.9,
                child: const SizedBox(
                    width: 178, height: 178, child: HeroRainbow()),
              ),
            ),
            // Scrim: keeps the left-aligned text readable over the artwork.
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.bgSoft,
                      AppColors.bgSoft.withOpacity(0.0),
                    ],
                    stops: const [0.52, 1.0],
                  ),
                ),
              ),
            ),
            // Text + CTA overlaid on top.
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 96, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('NUTRITION RAINBOW',
                      style: AppText.body(
                          size: 11,
                          weight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: AppColors.green)),
                  const SizedBox(height: 8),
                  Text(
                    'Transforming nutritional data into healthier choices — '
                    'accessibly and accurately.',
                    style: AppText.fredoka(
                        size: 18, weight: FontWeight.w500, height: 1.3),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow:
                          AppShadows.glow(AppColors.green, opacity: 0.3),
                    ),
                    child: Material(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(100),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () => context
                            .read<ShellController>()
                            .goTo(ShellController.rainbow),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Explore the Rainbow',
                                  style: AppText.body(
                                      size: 13.5,
                                      weight: FontWeight.w700,
                                      color: Colors.white)),
                              const SizedBox(width: 6),
                              const Icon(Icons.arrow_forward_rounded,
                                  size: 16, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// (Mission / Vision / Values now live only on the About Us page.)
