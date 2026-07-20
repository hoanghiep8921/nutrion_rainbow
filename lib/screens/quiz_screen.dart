import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/common.dart';
import '../widgets/quiz_option.dart';
import '../widgets/rings.dart';

/// A generic quiz engine. It runs any list of [QuizQuestion]s with a timer and
/// scoring, then hands the result to [onSubmit] (which records XP / progress)
/// and shows the screen built by [resultBuilder].
///
/// This is reused by both the color lessons and the food-group quizzes.
class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.questions,
    required this.onSubmit,
    required this.resultBuilder,
  });

  final List<QuizQuestion> questions;
  final Future<QuizOutcome> Function(int correct, int total) onSubmit;
  final Widget Function(QuizOutcome outcome) resultBuilder;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const int _perQuestionSeconds = 20;

  int _index = 0;
  int? _selected;
  bool _answered = false;
  bool _timedOut = false; // the current question ran out of time (unanswered)
  int _correct = 0;

  Timer? _timer;
  int _secondsLeft = _perQuestionSeconds;

  List<QuizQuestion> get _questions => widget.questions;
  QuizQuestion get _q => _questions[_index];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = _perQuestionSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        _secondsLeft--;
        if (_secondsLeft <= 0) {
          t.cancel();
          _reveal(null); // time up → counts as unanswered
        }
      });
    });
  }

  void _reveal(int? choice) {
    if (_answered) return;
    _timer?.cancel();
    setState(() {
      _selected = choice;
      _answered = true;
      _timedOut = choice == null; // null == ran out of time
      if (choice != null && choice == _q.correctIndex) _correct++;
    });
  }

  Future<void> _next() async {
    if (_index + 1 < _questions.length) {
      setState(() {
        _index++;
        _selected = null;
        _answered = false;
        _timedOut = false;
      });
      _startTimer();
    } else {
      final outcome = await widget.onSubmit(_correct, _questions.length);
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => widget.resultBuilder(outcome)),
      );
    }
  }

  String get _timeLabel {
    final s = _secondsLeft.clamp(0, 99).toInt();
    return '0:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final en = context.watch<AppState>().isEnglish;
    final opts = en ? (_q.optionsEn ?? _q.options) : _q.options;
    final runningPoints = _correct * AppState.xpPerCorrect;
    final progress = (_index + (_answered ? 1 : 0)) / _questions.length;

    return Scaffold(
      backgroundColor: AppColors.bgWarm,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
          child: Column(
            children: [
              // ── Top bar: close · progress · points ──
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: const Text('✕', style: TextStyle(fontSize: 22)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ProgressBar(
                      value: progress,
                      color: AppColors.green,
                      height: 12,
                      background: AppColors.lineDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('⚡ $runningPoints',
                      style: AppText.body(
                          size: 15,
                          weight: FontWeight.w700,
                          color: AppColors.streak)),
                ],
              ),
              const SizedBox(height: 24),

              // ── Question meta ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      en
                          ? 'Q ${_index + 1} / ${_questions.length}'
                          : 'CÂU ${_index + 1} / ${_questions.length}',
                      style: AppText.body(
                          size: 13,
                          weight: FontWeight.w700,
                          letterSpacing: 0.6,
                          color: AppColors.green)),
                  Text('⏱ $_timeLabel',
                      style: AppText.body(
                          size: 13,
                          color: _secondsLeft <= 5
                              ? AppColors.red
                              : AppColors.muted2)),
                ],
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(en ? _q.questionEn : _q.question,
                    style: AppText.fredoka(size: 22, height: 1.35)),
              ),
              const SizedBox(height: 16),

              // ── Time-up notice (shown only when the question was not answered) ──
              if (_answered && _timedOut) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFECEC),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.red.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      const Text('⏱', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          en
                              ? 'Time\'s up — you didn\'t answer. The correct '
                                  'answer is highlighted in green.'
                              : 'Hết giờ — bạn chưa trả lời câu này. Đáp án '
                                  'đúng được tô xanh.',
                          style: AppText.body(
                              size: 12.5,
                              weight: FontWeight.w600,
                              color: AppColors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ] else
                const SizedBox(height: 8),

              // ── Options ──
              Expanded(
                child: ListView.separated(
                  itemCount: opts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) => QuizOptionCard(
                    letter: String.fromCharCode(65 + i), // A, B, C, D
                    text: opts[i],
                    state: _stateFor(i),
                    onTap: _answered ? null : () => _reveal(i),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              PrimaryButton(
                label: _index + 1 < _questions.length
                    ? (en ? 'Next →' : 'Tiếp tục →')
                    : (en ? 'See result →' : 'Xem kết quả →'),
                color: AppColors.green,
                enabled: _answered,
                onTap: _next,
              ),
            ],
          ),
        ),
      ),
    );
  }

  QuizOptionState _stateFor(int i) {
    if (!_answered) return QuizOptionState.idle;
    if (i == _q.correctIndex) return QuizOptionState.correct;
    if (i == _selected) return QuizOptionState.wrong;
    return QuizOptionState.dimmed;
  }
}
