import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/food_quiz_data.dart';
import '../data/nutrition_data.dart';
import '../models/food_quiz.dart';
import '../models/models.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';
import 'food_quiz_result_screen.dart';
import 'quiz_result_screen.dart';
import 'quiz_screen.dart';

class QuizHubScreen extends StatelessWidget {
  const QuizHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final en = state.isEnglish;
    // One mixed list: color quizzes (fruit & veg) interleaved with other
    // food groups (meat, fish, dairy, grains, plant protein).
    final rows = <Widget>[];
    final n = kColors.length > kFoodQuizzes.length
        ? kColors.length
        : kFoodQuizzes.length;
    for (var i = 0; i < n; i++) {
      if (i < kColors.length) {
        final c = kColors[i];
        rows.add(_QuizRow(
          color: c,
          en: en,
          unlocked: state.isUnlocked(c.id),
          best: state.bestScoreOf(c.id),
          total: c.quiz.length,
          onTap: state.isUnlocked(c.id)
              ? () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(
                        questions: c.quiz,
                        onSubmit: (correct, total) =>
                            state.finishQuiz(c.id, correct, total),
                        resultBuilder: (o) =>
                            QuizResultScreen(color: c, outcome: o),
                      ),
                    ),
                  )
              : null,
        ));
        rows.add(const SizedBox(height: 12));
      }
      if (i < kFoodQuizzes.length) {
        final t = kFoodQuizzes[i];
        rows.add(_FoodQuizRow(
          topic: t,
          en: en,
          best: state.foodBestScoreOf(t.id),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => QuizScreen(
                questions: t.quiz,
                onSubmit: (correct, total) =>
                    state.finishFoodQuiz(t.id, correct, total),
                resultBuilder: (o) =>
                    FoodQuizResultScreen(topic: t, outcome: o),
              ),
            ),
          ),
        ));
        rows.add(const SizedBox(height: 12));
      }
    }

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(en ? 'Quiz Challenge' : 'Thử thách Quiz',
                style: AppText.fredoka(size: 26)),
            const SizedBox(height: 2),
            Text(
                en
                    ? 'Fruit, veg, meat, fish, eggs, grains… · Earn XP'
                    : 'Rau củ, thịt, cá, trứng, ngũ cốc… · Earn XP',
                style: AppText.body(size: 14, color: AppColors.muted2)),
            const SizedBox(height: 20),
            ...rows,
          ],
        ),
      ),
    );
  }
}

class _QuizRow extends StatelessWidget {
  const _QuizRow({
    required this.color,
    required this.en,
    required this.unlocked,
    required this.best,
    required this.total,
    required this.onTap,
  });

  final NutritionColorInfo color;
  final bool en;
  final bool unlocked;
  final int best;
  final int total;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppShadows.small,
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: unlocked ? color.color.withOpacity(0.14) : AppColors.chip,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Opacity(
                  opacity: unlocked ? 1 : 0.5,
                  child: FoodIcons(color.icons, size: 20),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      en
                          ? '${color.nameEn} · ${color.compound}'
                          : 'Màu ${color.name} · ${color.compound}',
                      style: AppText.fredoka(size: 16, weight: FontWeight.w500)),
                  const SizedBox(height: 3),
                  Text(
                    !unlocked
                        ? (en
                            ? 'Learn this color first to unlock'
                            : 'Mở khóa bằng cách học màu trước')
                        : best > 0
                            ? (en
                                ? 'Best: $best/$total · $total questions'
                                : 'Kỷ lục: $best/$total · $total câu hỏi')
                            : (en
                                ? 'Not tried · $total questions'
                                : 'Chưa thử · $total câu hỏi'),
                    style: AppText.body(size: 13, color: AppColors.muted2),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (unlocked)
              Container(
                width: 38,
                height: 38,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: color.color),
                child: Center(
                  child: Icon(Icons.play_arrow_rounded,
                      color: color.onColor, size: 22),
                ),
              )
            else
              const Text('🔒', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _FoodQuizRow extends StatelessWidget {
  const _FoodQuizRow({
    required this.topic,
    required this.en,
    required this.best,
    required this.onTap,
  });

  final FoodQuizTopic topic;
  final bool en;
  final int best;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onTopic =
        topic.color.computeLuminance() > 0.6 ? AppColors.ink : Colors.white;
    final total = topic.quiz.length;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppShadows.small,
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: topic.color.withOpacity(0.14),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                  child: Text(topic.emoji, style: const TextStyle(fontSize: 26))),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(en ? topic.titleEn : topic.title,
                      style: AppText.fredoka(size: 16, weight: FontWeight.w500)),
                  const SizedBox(height: 3),
                  Text(
                    best > 0
                        ? (en
                            ? 'Best: $best/$total · $total questions'
                            : 'Kỷ lục: $best/$total · $total câu hỏi')
                        : (en ? (topic.blurbEn ?? topic.blurb) : topic.blurb),
                    style: AppText.body(size: 13, color: AppColors.muted2),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 38,
              height: 38,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: topic.color),
              child: Center(
                child: Icon(Icons.play_arrow_rounded, color: onTopic, size: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
