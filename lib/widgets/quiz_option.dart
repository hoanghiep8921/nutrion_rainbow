import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import 'common.dart';

/// Visual state of a single quiz answer option.
enum QuizOptionState { idle, correct, wrong, dimmed }

/// A single tappable answer option, shared by every quiz (color lessons and
/// food-group quizzes) so they look and behave identically.
class QuizOptionCard extends StatelessWidget {
  const QuizOptionCard({
    super.key,
    required this.letter,
    required this.text,
    required this.state,
    required this.onTap,
  });

  final String letter; // A, B, C, D
  final String text;
  final QuizOptionState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.white;
    Color border = AppColors.lineDark;
    Color chipBg = AppColors.chip;
    Color chipText = AppColors.muted2;
    Color textColor = AppColors.ink;
    Widget? trailing;
    List<BoxShadow>? shadow;

    switch (state) {
      case QuizOptionState.idle:
        break;
      case QuizOptionState.correct:
        bg = const Color(0xFFE9F9F0);
        border = AppColors.green;
        chipBg = AppColors.green;
        chipText = Colors.white;
        textColor = AppColors.greenInk;
        trailing = const Text('✅', style: TextStyle(fontSize: 20));
        shadow = AppShadows.glow(AppColors.green, opacity: 0.18);
        break;
      case QuizOptionState.wrong:
        bg = const Color(0xFFFFECEC);
        border = AppColors.red;
        chipBg = AppColors.red;
        chipText = Colors.white;
        textColor = AppColors.red;
        trailing = const Text('❌', style: TextStyle(fontSize: 20));
        break;
      case QuizOptionState.dimmed:
        textColor = AppColors.muted2;
        break;
    }

    return Opacity(
      opacity: state == QuizOptionState.dimmed ? 0.6 : 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: border, width: 2),
            boxShadow: shadow,
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: chipBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(letter,
                      style: AppText.fredoka(
                          size: 15, weight: FontWeight.w600, color: chipText)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(text,
                    style: AppText.body(
                        size: 16, weight: FontWeight.w500, color: textColor)),
              ),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }
}
