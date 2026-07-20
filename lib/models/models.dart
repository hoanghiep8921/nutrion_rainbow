import 'package:flutter/material.dart';

/// A single food example inside a lesson (emoji + label).
class FoodItem {
  const FoodItem(this.emoji, this.name, [this.nameEn]);
  final String emoji;
  final String name;
  final String? nameEn; // English label (falls back to [name])
}

/// One multiple-choice quiz question.
class QuizQuestion {
  const QuizQuestion({
    required this.question,
    required this.questionEn,
    required this.options,
    required this.correctIndex,
    this.optionsEn,
  });

  final String question;
  final String questionEn;
  final List<String> options;
  final int correctIndex;
  final List<String>? optionsEn; // English options (falls back to [options])
}

/// All learning content for one of the six nutrition colors.
class NutritionColorInfo {
  const NutritionColorInfo({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.compound,
    required this.benefit,
    required this.benefitEn,
    required this.emoji,
    required this.icons,
    required this.color,
    required this.colorLight,
    required this.onColor,
    required this.description,
    required this.foods,
    required this.funFact,
    required this.quiz,
    this.descriptionEn,
    this.funFactEn,
  });

  final String id; // e.g. 'red'
  final String name; // e.g. 'Đỏ'
  final String nameEn; // e.g. 'Red'
  final String compound; // e.g. 'Lycopene'
  final String benefit; // e.g. 'Tốt cho tim mạch'
  final String benefitEn; // e.g. 'Heart'
  final String emoji; // e.g. '🍅'
  final List<String> icons; // representative foods (produce + meat/fish/etc.)
  final Color color; // primary color
  final Color colorLight; // gradient partner
  final Color onColor; // text color on top of [color]
  final String description; // rich lesson paragraph (VI)
  final String? descriptionEn; // English paragraph (falls back to [description])
  final List<FoodItem> foods; // example foods
  final String funFact; // "Did you know?" tip (VI)
  final String? funFactEn; // English tip (falls back to [funFact])
  final List<QuizQuestion> quiz; // questions for this color

  /// XP awarded for reading the lesson.
  int get lessonXp => 20;
}

/// An achievement badge.
class BadgeInfo {
  const BadgeInfo({
    required this.id,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });

  final String id;
  final String emoji;
  final String title;
  final String subtitle;
  final List<Color> gradient;
}

/// A leaderboard entry.
class LeaderEntry {
  const LeaderEntry({
    required this.name,
    required this.emoji,
    required this.xp,
    this.isYou = false,
  });

  final String name;
  final String emoji;
  final int xp;
  final bool isYou;
}

/// Per-color learning status used by the UI.
enum ColorStatus { locked, unlocked, completed }
