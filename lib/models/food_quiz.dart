import 'package:flutter/material.dart';

import 'models.dart';

/// A non-color quiz topic covering general foods (meat, fish, dairy, grains,
/// plant protein) so learning isn't limited to fruit and vegetables.
class FoodQuizTopic {
  const FoodQuizTopic({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.emoji,
    required this.color,
    required this.blurb,
    required this.quiz,
    this.blurbEn,
  });

  final String id;
  final String title; // Vietnamese
  final String titleEn; // English
  final String emoji;
  final Color color;
  final String blurb; // short Vietnamese description
  final String? blurbEn; // English description (falls back to [blurb])
  final List<QuizQuestion> quiz;
}
