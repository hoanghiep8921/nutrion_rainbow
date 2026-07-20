import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';
import 'quiz_result_screen.dart';
import 'quiz_screen.dart';

class LessonDetailScreen extends StatefulWidget {
  const LessonDetailScreen({super.key, required this.color});

  final NutritionColorInfo color;

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Reading the lesson awards XP the first time.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<AppState>().markLessonRead(widget.color.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.color;
    final en = context.watch<AppState>().isEnglish;
    final potentialXp = c.quiz.length * AppState.xpPerCorrect;

    return Scaffold(
      backgroundColor: AppColors.bgWarm,
      body: Column(
        children: [
          _Header(color: c, en: en),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(en ? (c.descriptionEn ?? c.description) : c.description,
                      style: AppText.body(
                          size: 15, height: 1.65, color: AppColors.inkSoft)),
                  const SizedBox(height: 22),
                  Text(
                      en
                          ? 'Suggested ${c.nameEn.toLowerCase()} foods'
                          : 'Gợi ý thực phẩm màu ${c.name}',
                      style: AppText.fredoka(size: 16, weight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text(
                      en
                          ? 'Fruit, veg — and even meat, fish and eggs of the same color'
                          : 'Rau củ, trái cây và cả thịt, cá, trứng… cùng màu',
                      style: AppText.body(size: 12.5, color: AppColors.muted2)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (final f in c.foods) _FoodCard(food: f, en: en),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _FunFact(
                      text: en ? (c.funFactEn ?? c.funFact) : c.funFact,
                      en: en),
                ],
              ),
            ),
          ),
          _BottomBar(
            child: PrimaryButton(
              label: en
                  ? 'Take the ${c.nameEn} quiz · +$potentialXp XP'
                  : 'Làm quiz màu ${c.name} · +$potentialXp XP',
              color: c.color,
              glowColor: c.color,
              textColor: c.onColor,
              onTap: () {
                final state = context.read<AppState>();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => QuizScreen(
                      questions: c.quiz,
                      onSubmit: (correct, total) =>
                          state.finishQuiz(c.id, correct, total),
                      resultBuilder: (o) =>
                          QuizResultScreen(color: c, outcome: o),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.color, required this.en});
  final NutritionColorInfo color;
  final bool en;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.color, color.colorLight],
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleButton(
                    icon: Icons.arrow_back_rounded,
                    onColor: color.onColor,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  Pill(
                    background: color.onColor == Colors.white
                        ? Colors.white.withOpacity(0.22)
                        : Colors.black.withOpacity(0.08),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Text(en ? color.benefitEn : color.benefit,
                        style: AppText.body(
                            size: 13,
                            weight: FontWeight.w600,
                            color: color.onColor)),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Bob(
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: color.onColor == Colors.white
                            ? Colors.white.withOpacity(0.2)
                            : Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Center(
                          child: Text(color.emoji,
                              style: const TextStyle(fontSize: 40))),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          en
                              ? color.nameEn.toUpperCase()
                              : 'MÀU ${color.name.toUpperCase()}',
                          style: AppText.body(
                              size: 13,
                              weight: FontWeight.w700,
                              letterSpacing: 0.8,
                              color: color.onColor.withOpacity(0.85))),
                      const SizedBox(height: 2),
                      Text(color.compound,
                          style: AppText.fredoka(size: 28, color: color.onColor)),
                    ],
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

class _CircleButton extends StatelessWidget {
  const _CircleButton(
      {required this.icon, required this.onColor, required this.onTap});
  final IconData icon;
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
        child: Icon(icon, color: onColor, size: 20),
      ),
    );
  }
}

class _FoodCard extends StatelessWidget {
  const _FoodCard({required this.food, required this.en});
  final FoodItem food;
  final bool en;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppShadows.small,
        ),
        child: Column(
          children: [
            Text(food.emoji, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 6),
            Text(en ? (food.nameEn ?? food.name) : food.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: AppText.body(
                    size: 12,
                    weight: FontWeight.w600,
                    color: AppColors.inkSoft)),
          ],
        ),
      ),
    );
  }
}

class _FunFact extends StatelessWidget {
  const _FunFact({required this.text, required this.en});
  final String text;
  final bool en;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.tipBg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('💡', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(en ? 'Did you know?' : 'Bạn có biết?',
                    style: AppText.fredoka(
                        size: 14,
                        weight: FontWeight.w500,
                        color: AppColors.tipTitle)),
                const SizedBox(height: 2),
                Text(text,
                    style: AppText.body(
                        size: 13, height: 1.55, color: AppColors.tipBody)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        child: child,
      ),
    );
  }
}
