import 'package:flutter_test/flutter_test.dart';
import 'package:nutrition_rainbow/data/badges_data.dart';
import 'package:nutrition_rainbow/data/nutrition_data.dart';
import 'package:nutrition_rainbow/state/app_state.dart';

void main() {
  group('Nutrition content integrity', () {
    test('there are exactly 6 colours in progression order', () {
      expect(kColors.length, 6);
      expect(kColors.map((c) => c.id).toList(),
          ['red', 'orange', 'yellow', 'green', 'blue', 'purple']);
    });

    test('every quiz question is well-formed', () {
      for (final c in kColors) {
        expect(c.quiz, isNotEmpty, reason: '${c.id} has no quiz');
        for (final q in c.quiz) {
          expect(q.options.length, 4,
              reason: 'Question "${q.question}" must have 4 options');
          expect(q.correctIndex, inInclusiveRange(0, q.options.length - 1),
              reason: 'correctIndex out of range for "${q.question}"');
          expect(q.question.trim(), isNotEmpty);
        }
      }
    });

    test('colorById resolves every id', () {
      for (final c in kColors) {
        expect(colorById(c.id).id, c.id);
      }
    });

    test('badge catalogue is non-empty and unique', () {
      expect(kBadges, isNotEmpty);
      final ids = kBadges.map((b) => b.id).toSet();
      expect(ids.length, kBadges.length, reason: 'duplicate badge id');
    });
  });

  group('QuizOutcome stars', () {
    QuizOutcome make(int correct, int total) => QuizOutcome(
          correct: correct,
          total: total,
          xpEarned: correct * 20,
          passed: correct >= 3,
          isNewBest: false,
          newBadges: const [],
        );

    test('perfect score = 3 stars', () => expect(make(5, 5).stars, 3));
    test('good score = 2 stars', () => expect(make(3, 5).stars, 2));
    test('poor score = 1 star', () => expect(make(1, 5).stars, 1));
    test('zero score = 0 stars', () => expect(make(0, 5).stars, 0));
  });
}
