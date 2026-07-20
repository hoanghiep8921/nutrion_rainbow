import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/food_quiz.dart';
import '../models/models.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';
import '../widgets/rings.dart';
import 'quiz_screen.dart';

/// Result screen for a food-group quiz. Themed by the topic color, with a
/// score ring, XP / streak and any newly earned badge.
class FoodQuizResultScreen extends StatelessWidget {
  const FoodQuizResultScreen({
    super.key,
    required this.topic,
    required this.outcome,
  });

  final FoodQuizTopic topic;
  final QuizOutcome outcome;

  Color get _onHeader =>
      topic.color.computeLuminance() > 0.6 ? AppColors.ink : Colors.white;

  void _done(BuildContext context) =>
      Navigator.of(context).popUntil((r) => r.isFirst);

  void _retry(BuildContext context) {
    final state = context.read<AppState>();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => QuizScreen(
          questions: topic.quiz,
          onSubmit: (c, t) => state.finishFoodQuiz(topic.id, c, t),
          resultBuilder: (o) => FoodQuizResultScreen(topic: topic, outcome: o),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final en = context.watch<AppState>().isEnglish;
    final passed = outcome.passed;
    return Scaffold(
      backgroundColor: AppColors.bgWarm,
      body: Column(
        children: [
          // ── Themed header ──
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  topic.color,
                  Color.lerp(topic.color, Colors.black, 0.22)!,
                ],
              ),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  children: [
                    Text(topic.emoji, style: const TextStyle(fontSize: 34)),
                    const SizedBox(height: 6),
                    Text(
                        passed
                            ? (en ? 'Great job! 🎉' : 'Tuyệt vời! 🎉')
                            : (en ? 'Keep going! 💪' : 'Cố lên nhé! 💪'),
                        style: AppText.fredoka(size: 26, color: _onHeader)),
                    const SizedBox(height: 4),
                    Text('Quiz: ${en ? topic.titleEn : topic.title}',
                        textAlign: TextAlign.center,
                        style: AppText.body(
                            size: 13.5,
                            color: _onHeader.withOpacity(0.92))),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
              child: Column(
                children: [
                  _ScoreCard(outcome: outcome, accent: topic.color, en: en),
                  if (outcome.newBadges.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _NewBadgeCard(badge: outcome.newBadges.first, en: en),
                  ],
                ],
              ),
            ),
          ),

          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 10),
              child: Column(
                children: [
                  PrimaryButton(
                    label: en ? 'Done' : 'Hoàn thành',
                    color: AppColors.green,
                    onTap: () => _done(context),
                  ),
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed: () => _retry(context),
                    child: Text(en ? 'Try again' : 'Làm lại quiz',
                        style: AppText.body(
                            size: 14,
                            weight: FontWeight.w600,
                            color: AppColors.muted2)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  const _ScoreCard(
      {required this.outcome, required this.accent, required this.en});
  final QuizOutcome outcome;
  final Color accent;
  final bool en;

  @override
  Widget build(BuildContext context) {
    final ringColor =
        accent.computeLuminance() > 0.6 ? AppColors.yellowInk : accent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        children: [
          ProgressRing(
            size: 130,
            strokeWidth: 12,
            progress: outcome.total == 0 ? 0 : outcome.correct / outcome.total,
            progressColor: ringColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${outcome.correct}/${outcome.total}',
                    style: AppText.fredoka(size: 38)),
                Text(en ? 'correct' : 'chính xác',
                    style: AppText.body(size: 12, color: AppColors.muted2)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < 3; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Opacity(
                    opacity: i < outcome.stars ? 1 : 0.28,
                    child: const Text('⭐', style: TextStyle(fontSize: 30)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _StatBox(
                  value: '+${outcome.xpEarned}',
                  label: en ? 'XP earned' : 'XP kiếm được',
                  bg: AppColors.tipBg,
                  valueColor: AppColors.streak,
                  labelColor: AppColors.tipTitle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatBox(
                  value: '🔥 ${context.watch<AppState>().streak}',
                  label: en ? 'Day streak' : 'Chuỗi ngày',
                  bg: const Color(0xFFE9F9F0),
                  valueColor: AppColors.greenInk,
                  labelColor: AppColors.greenInk,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.value,
    required this.label,
    required this.bg,
    required this.valueColor,
    required this.labelColor,
  });

  final String value;
  final String label;
  final Color bg;
  final Color valueColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(value, style: AppText.fredoka(size: 22, color: valueColor)),
          const SizedBox(height: 2),
          Text(label, style: AppText.body(size: 12, color: labelColor)),
        ],
      ),
    );
  }
}

class _NewBadgeCard extends StatelessWidget {
  const _NewBadgeCard({required this.badge, required this.en});
  final BadgeInfo badge;
  final bool en;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: badge.gradient),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
                child: Text(badge.emoji, style: const TextStyle(fontSize: 26))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(en ? 'New badge!' : 'Huy hiệu mới!',
                    style: AppText.fredoka(size: 15, weight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(badge.title,
                    style: AppText.body(size: 13, color: AppColors.muted2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
